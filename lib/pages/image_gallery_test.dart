import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';
import '../model/albums.dart';
import '../model/gallery_state.dart';
import "../widgets/album_design.dart" as ui;
import 'image_dialog.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({Key? key}) : super(key: key);
  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      Provider.of<GalleryState>(context, listen: false)
          .getAlbums()
          .then((value) => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wrapper = ResponsiveWrapper.of(context);
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      autofocus: true,
      child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Consumer<GalleryState>(builder: (context, model, child) {
              return wrapper.isSmallerThan(DESKTOP)
                  ? SizedBox(
                      // height: size.height * 0.9,
                      width: size.width * 0.8,
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        children: model.action == GalleryAction.NONE
                            ? [
                                Material(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.blueGrey.shade300,
                                    highlightColor: Colors.blueGrey.shade100,
                                    enabled: true,
                                    child: BannerPlaceholder(),
                                  ),
                                ),
                                Material(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.blueGrey.shade300,
                                    highlightColor: Colors.blueGrey.shade100,
                                    enabled: true,
                                    child: BannerPlaceholder(),
                                  ),
                                ),
                              ]
                            : model.action == GalleryAction.ALBUMS
                                ? List.generate(
                                    model.albums.length,
                                    (index) {
                                      Album al = model.albums[index];
                                      return InkWell(
                                        child: SizedBox(
                                          height: size.height * 0.4,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16.0),
                                            child: ui.Album(
                                              album: model.albums[index],
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          showDialog(
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    Text("Getting Images..."),
                                                content: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: Colors.blue),
                                                  ),
                                                ),
                                              );
                                            },
                                            context: this.context,
                                          );
                                          final images =
                                              await model.getImages(id: al.id!);
                                          if (images != null) {
                                            Navigator.pop(context);
                                            displayDialog(
                                              context,
                                              images,
                                            );
                                          } else {
                                            Navigator.pop(context);
                                          }
                                        },
                                      );
                                    },
                                  )
                                : model.action == GalleryAction.Error
                                    ? [Center(child: Text(model.errorMessage))]
                                    : [],
                      ),
                    )
                  : GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: size.width * 0.4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.2,
                      ),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      children: model.action == GalleryAction.NONE
                          ? [
                              Material(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.blueGrey.shade300,
                                  highlightColor: Colors.blueGrey.shade100,
                                  enabled: true,
                                  child: BannerPlaceholder(),
                                ),
                              ),
                              Material(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.blueGrey.shade300,
                                  highlightColor: Colors.blueGrey.shade100,
                                  enabled: true,
                                  child: BannerPlaceholder(),
                                ),
                              ),
                            ]
                          : model.action == GalleryAction.ALBUMS
                              ? List.generate(
                                  model.albums.length,
                                  (index) {
                                    Album al = model.albums[index];
                                    return InkWell(
                                      child:
                                          ui.Album(album: model.albums[index]),
                                      onTap: () async {
                                        showDialog(
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Getting Images..."),
                                              content: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.blue),
                                                ),
                                              ),
                                            );
                                          },
                                          context: this.context,
                                        );
                                        final images =
                                            await model.getImages(id: al.id!);
                                        if (images != null) {
                                          Navigator.pop(context);
                                          displayDialog(
                                            context,
                                            images,
                                          );
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                    );
                                  },
                                )
                              : model.action == GalleryAction.Error
                                  ? [Center(child: Text(model.errorMessage))]
                                  : [],
                    );
            }),
          ],
        ),
      ),
    );
  }

  void displayDialog(BuildContext context, List<ImageDetail> images) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ImageDialog(
        imageUrls: List.generate(images.length, (index) {
          // print(images[index].url);
          return images[index].url;
        }),
        initialIndex: 0,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    }
  }
}

class BannerPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: responsiveWrapper.isSmallerThan(DESKTOP)
          ? size.width * 0.8
          : size.width * 0.2,
      height: size.height * 0.4,
      color: Colors.green,
    );
  }
}

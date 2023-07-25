import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        Consumer<GalleryState>(builder: (context, model, child) {
          return GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: size.width * 0.40,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: model.action == GalleryAction.NONE
                ? [
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ]
                : model.action == GalleryAction.ALBUMS
                    ? List.generate(
                        model.albums.length,
                        (index) {
                          Album al = model.albums[index];
                          return InkWell(
                            child: ui.Album(album: model.albums[index]),
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
                                        child: CircularProgressIndicator(
                                            color: Colors.blue),
                                      ),
                                    ),
                                  );
                                },
                                context: this.context,
                              );
                              final images = await model.getImages(id: al.id!);
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
    );
  }

  void displayDialog(BuildContext context, List<ImageDetail> images) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ImageDialog(
        imageUrls: List.generate(images.length, (index) {
          return images[index].url;
        }),
        initialIndex: 0,
      ),
    );
  }
}

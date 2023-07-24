import 'dart:convert';
import 'package:flutter/material.dart';
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
  bool galleryInfoAvailable = false;
  List<Album> albums = [];
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000)).then((value) {
      DefaultAssetBundle.of(context)
          .loadString("assets/data/albums.json")
          .then((value) {
        var jsonData = jsonDecode(value);

        for (var item in jsonData["albums"]) {
          albums.add(Album.fromJson(item));
        }
        setState(() {
          galleryInfoAvailable = !galleryInfoAvailable;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width * 0.40,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: !galleryInfoAvailable
              ? [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ]
              : List.generate(
                  albums.length,
                  (index) {
                    return InkWell(
                      child: ui.Album(album: albums[index]),
                      onTap: () {
                        Album al = albums[index];
                        List<ImageDetail> images = [];
                        DefaultAssetBundle.of(context)
                            .loadString("assets/data/images.json")
                            .then((value) {
                          var jsonData = jsonDecode(value)["list"];
                          for (var item in jsonData) {
                            int alId = item["albumId"];
                            if (alId == al.id) {
                              for (var item in item["images"]) {
                                images.add(ImageDetail.fromJson(item));
                              }
                            }
                          }
                          displayDialog(context, images);
                        });
                      },
                    );
                  },
                ),
        ),
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

import 'package:flutter/cupertino.dart';

enum GalleryAction { NONE, EDIT, DETAIL }

class ImageDetail {
  late String url;
  late String alternativeImageLink;
  late String alternateText;
  late String title;
  late String description;

  ImageDetail.fromJson(Map<String, dynamic> json) {
    this.alternateText = json["alternativeText"];
    this.alternativeImageLink = json["alternativeUrl"];
    this.title = json["title"];
    this.description = json["description"];
    this.url = json["url"];
  }
}

class GalleryState with ChangeNotifier {
  GalleryAction _action = GalleryAction.NONE;
  List<ImageDetail> _images = <ImageDetail>[];

  GalleryState() {
    // ImageRepo().getImages(limit: 5).then((value) {
    //   _images = value;
    //   notifyListeners();
    // });
  }
  set action(GalleryAction ac) {
    this._action = ac;
    notifyListeners();
  }

  GalleryAction get action => _action;
  set image(ImageDetail image) {
    _images.add(image);
    notifyListeners();
  }

  List<ImageDetail> get images => images;
}

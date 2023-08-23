import 'package:flutter/cupertino.dart';
import 'package:trishaheed/model/albums.dart';

import '../repository/gallery_repo.dart';

enum GalleryAction { NONE, ALBUMS, EDIT, IMAGES, Error }

class ImageDetail {
  int? id;
  late String url;
  String? alternativeImageLink;
  late String createdAt;
  late String updatedAt;

  ImageDetail.fromJson(Map<String, dynamic> json) {
    print(json["image_url"]);
    this.id = json["id"];
    this.url = json["image_url"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
  }
}

class GalleryState with ChangeNotifier {
  GalleryAction _action = GalleryAction.NONE;
  List<Album> albums = <Album>[];
  String errorMessage = "";

  GalleryState() {}
  set action(GalleryAction ac) {
    this._action = ac;
    notifyListeners();
  }

  GalleryAction get action => _action;

  Future<void> getAlbums() async {
    ImageRepo().getAlbums().then((value) {
      value.fold((l) {
        albums = l;
        action = GalleryAction.ALBUMS;
      }, (r) {
        errorMessage = r;
        action = GalleryAction.Error;
      });
    });
    notifyListeners();
  }

  Future<List<ImageDetail>?> getImages({required int id}) async {
    List<ImageDetail> _images = <ImageDetail>[];
    final response = await ImageRepo().getImagesForAlbum(id);
    response.fold((l) {
      _images = l;
    }, (r) {
      debugPrint(r);
      errorMessage = r;
      action = GalleryAction.Error;
    });
    if (_images.length > 0) return _images;
    return null;
  }
}

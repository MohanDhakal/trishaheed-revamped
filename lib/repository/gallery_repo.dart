import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:trishaheed/model/gallery_state.dart';
import '../model/albums.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';

class ImageRepo {
  Future<Either<List<Album>, String>> getAlbums() async {
    final response = await BaseApi.createDio().get(ApiRoutes.albums);
    List<Album> albums = <Album>[];
    String failedMsg = "";
    response.fold((l) {
      for (var element in l.data) {
        albums.add(Album.fromApi(element));
      }
    }, (r) {
      debugPrint(r.message + r.code.toString());
      failedMsg = r.message;
    });
    if (failedMsg.isEmpty)
      return Left(albums);
    else
      return Right(failedMsg);
  }

  Future<Either<List<ImageDetail>, String>> getImagesForAlbum(int id) async {
    final response = await BaseApi.createDio().get(ApiRoutes.images + '$id');
    List<ImageDetail> urlList = <ImageDetail>[];
    String failedMsg = "";
    response.fold((l) {
      for (var element in l.data) {
        final url = ImageDetail.fromJson(element);
        urlList.add(url);
      }
    }, (r) {
      debugPrint(r.message + r.code.toString());
      failedMsg = r.message;
    });
    if (failedMsg.isEmpty)
      return Left(urlList);
    else
      return Right(failedMsg);
  }
}

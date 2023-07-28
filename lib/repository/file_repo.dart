import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trishaheed/model/Download.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';
import '../utilities/globals.dart';

class FileRepo {
  Future<Download?> listFiles(String folder) async {
    final response = await BaseApi.createDio().get(ApiRoutes.files + '$folder');
    Download? download;
    response.fold((l) {
      download = Download.fromJson(l.data);
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return download;
  }

  Future<Uint8List?> downloadFile(String filePath) async {
    print("${Globals.Url + ApiRoutes.fileDownload + filePath}");
    try {
      Dio dio = Dio();
      Response<Uint8List> response =
          await dio.get<Uint8List>("${Globals.Url + ApiRoutes.fileDownload}",
              options: Options(
                responseType: ResponseType.bytes,
              ),
              queryParameters: {
            "file_path": filePath,
          });
      return response.data;
    } catch (e) {
      // Handle any errors that might occur during the API request.
      print("Error fetching image data: $e");
      return null;
    }
  }

  //   final response = await BaseApi.createDio()
  //       .get(ApiRoutes.fileDownload, {"file_path": filePath});
  //   String? file;
  //   response.fold((l) {
  //     file = l.data;
  //   }, (r) {
  //     debugPrint(r.message + r.code.toString());
  //   });
  //   return file;
  // }
}

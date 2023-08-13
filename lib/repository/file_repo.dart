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
    print("${Globals.Url + ApiRoutes.fileDownload}");
    try {
      Response<Uint8List> response = await Dio(
        BaseOptions(
          baseUrl: Globals.Url,
          receiveTimeout: Duration(seconds: 30), // 15 seconds
          connectTimeout: Duration(seconds: 30),
          sendTimeout: Duration(seconds: 30),
          responseType: ResponseType.bytes,
          headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials":
                true, // Required for cookies, aut
            "Access-Control-Allow-Methods": "GET, OPTIONS",
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          },
        ),
      ).get<Uint8List>(
        ApiRoutes.fileDownload,
        queryParameters: {
          "file_path": filePath,
        },
      );
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

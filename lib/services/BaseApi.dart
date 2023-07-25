import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../utilities/Error.dart';
import '../utilities/globals.dart';

class BaseApi {
  late Dio dio;
  BaseApi.createDio([String? accessToken]) {
    var dio = Dio(BaseOptions(
      baseUrl: Globals.Url,
      receiveTimeout: Duration(seconds: 15), // 15 seconds
      connectTimeout: Duration(seconds: 15),
      sendTimeout: Duration(seconds: 15),
    ));
    dio.options.headers['Accept'] = 'application/json';
    if (accessToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    this.dio = dio;
  }

  Future<Either<Response, Failure>> post(Map<String, dynamic> data, String path,
      [bool hasImage = false]) async {
    Failure failure = new Failure("failure message", FailureType.OTHER);
    try {
      if (hasImage) {
        print("Image is present");
        data["image"] = await MultipartFile.fromBytes(data['image'].toList(),
            filename: "sample_image");
      }
      final response = await dio.post(path, data: FormData.fromMap(data));
      print("BaseApi After: $response");
      return Left(response);
    } on DioError catch (e) {
      print("BaseApi After DioError: " + e.toString());
      final dioError = getDioErrorMsg(failure, e);
      return Right(dioError);
    } catch (e) {
      print("BaseApi After LocalError: " + e.toString());
      final error = getLocalErrorMsg(failure, e);
      return Right(error);
    }
  }

  Future<Either<Response, Failure>> get(String path,
      [Map<String, dynamic>? queryParameters]) async {
    Failure failure = new Failure("failure message", FailureType.OTHER);
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      // print("response $response");
      return Left(response);
    } on DioError catch (e) {
      final dioError = getDioErrorMsg(failure, e);
      return Right(dioError);
    } catch (e) {
      final error = getLocalErrorMsg(failure, e);
      return Right(error);
    }
  }

  Future<Either<Response, Failure>> delete(String path) async {
    Failure failure = new Failure("failure message", FailureType.OTHER);
    try {
      final response = await dio.delete(path);
      // print("response $response");
      return Left(response);
    } on DioError catch (e) {
      final dioError = getDioErrorMsg(failure, e);
      return Right(dioError);
    } catch (e) {
      final error = getLocalErrorMsg(failure, e);
      return Right(error);
    }
  }
}

Failure getDioErrorMsg(Failure failure, DioError e) {
  switch (e.type) {
    case DioErrorType.connectionError:
      failure.message = e.message ?? "connection error";
      failure.type = FailureType.SERVER;
      return failure;
    case DioErrorType.badResponse:
      failure.message = e.message ?? "Bad Response";
      failure.type = FailureType.SERVER;
      return failure;
    case DioErrorType.connectionTimeout:
      failure.message = e.message ?? "Connection Timeout ";
      failure.type = FailureType.SERVER;
      return failure;
    case DioErrorType.receiveTimeout:
      failure.message = e.message ?? "Receive Time Out ";
      failure.type = FailureType.SERVER;
      return failure;
    case DioErrorType.sendTimeout:
      failure.message = e.message ?? "Request send timeout ";
      failure.type = FailureType.SERVER;
      return failure;
    default:
      failure.message = e.message ?? "Unknown Errior";
      failure.type = FailureType.SERVER;
      return failure;
  }
}

Failure getLocalErrorMsg(Failure failure, e) {
  failure.message = "error occured in client side";
  failure.type = FailureType.LOCAL;
  debugPrint(e.toString());
  return failure;
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:trishaheed/services/HiveStorage.dart';
import 'package:trishaheed/services/TempCacheInterceptor.dart';
import 'package:trishaheed/services/hive_cache_manager.dart';
import 'package:trishaheed/utilities/api_routes.dart';
import '../utilities/Error.dart';
import '../utilities/globals.dart';
import 'HiveCacheInterceptor.dart';

class BaseApi {
  late Dio dio;
  BaseApi() {
    BaseApi.createDio();
  }
  BaseApi.createDio([String? accessToken]) {
    var dio = Dio(
      BaseOptions(
        baseUrl: Globals.Url,
        receiveTimeout: Duration(seconds: 30),
        connectTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
      ),
    );
    dio.options.headers['Accept'] = '*/*';
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
        data["image"] = await MultipartFile.fromBytes(data['image'].toList(),
            filename: "sample_image");
      }
      final response = await dio.post(path, data: FormData.fromMap(data));
      return Left(response);
    } on DioException catch (e) {
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
      Response? response;
      if (path == ApiRoutes.posts || path.startsWith(ApiRoutes.postDetail)) {
        final hiveCache = HiveCacheStore();
        dio.interceptors..add(HiveCacheInterceptor(hiveCache));
        response = await dio.get(path, queryParameters: queryParameters);
      } else {
        CacheManager tempCache = CacheManager();
        final inteceptor = CacheInterceptor(tempCache);
        dio.interceptors..add(inteceptor);
        response = await dio.get(path, queryParameters: queryParameters);
      }
      return Left(response);
    } on DioException catch (e) {
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
      return Left(response);
    } on DioException catch (e) {
      final dioError = getDioErrorMsg(failure, e);
      return Right(dioError);
    } catch (e) {
      final error = getLocalErrorMsg(failure, e);
      return Right(error);
    }
  }
}

Failure getDioErrorMsg(Failure failure, DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      failure.message = e.message ?? "connection error";
      failure.type = FailureType.SERVER;
      return failure;
    case DioExceptionType.badResponse:
      failure.message = e.message ?? "Bad Response";
      failure.type = FailureType.SERVER;
      return failure;
    case DioExceptionType.connectionTimeout:
      failure.message = e.message ?? "Connection Timeout ";
      failure.type = FailureType.SERVER;
      return failure;
    case DioExceptionType.receiveTimeout:
      failure.message = e.message ?? "Receive Time Out ";
      failure.type = FailureType.SERVER;
      return failure;
    case DioExceptionType.sendTimeout:
      failure.message = e.message ?? "Request send timeout ";
      failure.type = FailureType.SERVER;
      return failure;
    default:
      failure.message = e.message ?? "Unknown Error";
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

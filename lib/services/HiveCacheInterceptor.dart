import 'package:dio/dio.dart';
import 'HiveStorage.dart';

class HiveCacheInterceptor extends Interceptor {
  final HiveCacheStore cacheStore;

  HiveCacheInterceptor(this.cacheStore);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final cacheKey = options.uri.toString();
    final cachedData = cacheStore.getCache(cacheKey);
    if (cachedData != null) {
      // Cast it to Map<String, dynamic>

      // Return the cached response
      final cachedResponse = Response(
        requestOptions: options,
        data: cachedData,
        statusCode: 200,
      );
      handler.resolve(cachedResponse);
    } else {
      // Continue with network request
      super.onRequest(options, handler);
    }
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    final cacheKey = response.requestOptions.uri.toString();

    // Store network response in cache
    await cacheStore.storeCache(cacheKey, response.data);

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Handle errors as needed
    super.onError(err, handler);
  }
}

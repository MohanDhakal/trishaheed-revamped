import 'package:dio/dio.dart';
import 'package:trishaheed/services/hive_cache_manager.dart';

class CacheInterceptor extends Interceptor {
  final CacheManager cacheStore;

  CacheInterceptor(this.cacheStore);
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Create a cache key using the request URL
    final cacheKey = options.uri.toString();

    // Check if the cache exists for this URL
    final cachedResponse = cacheStore.getCachedData(cacheKey);

    if (cachedResponse != null) {
      // If cache exists, return the cached data
      print('Cache hit for $cacheKey');
      return handler.resolve(Response(
        requestOptions: options,
        data: cachedResponse,
        statusCode: 200,
      ));
    }

    // If no cache, proceed with the request
    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // Cache the response based on the URL
    final cacheKey = response.requestOptions.uri.toString();
    await cacheStore.cacheData(cacheKey, response.data);

    // Proceed with the response
    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle errors (optional)
    return handler.next(err);
  }
}

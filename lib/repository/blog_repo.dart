
import 'package:flutter/material.dart';
import 'package:trishaheed/model/blog.dart';
import 'package:trishaheed/model/user.dart';
import 'package:trishaheed/services/BaseApi.dart';
import 'package:trishaheed/utilities/api_routes.dart';

class BlogApi {
  late BaseApi _baseApi;
  BlogApi(BaseApi api) {
    _baseApi = api;
  }

  Future<BlogWrapper?> getBlogList({int page = 1}) async {
    final response = await _baseApi.get(ApiRoutes.posts, {"page": page});
    List<Blog> blogs = <Blog>[];
    BlogWrapper? wrapper ;
    response.fold((l) {
      wrapper?.totalPages = l.data["last_page"];
      wrapper?.currentPage = l.data["current_page"];
      for (var element in l.data["data"]) {
        final item = Blog.fromJson(element);
        blogs.add(item);
      }
      wrapper?.blogList = blogs;
    }, (r) {
      debugPrint(r.message);
    });
    return wrapper;
  }

  Future<Blog?> getBlogForId(int id) async {
    final response = await _baseApi.get(ApiRoutes.postDetail + "$id");
    Blog? local;
    response.fold((l) {
      print(l.data.runtimeType);
      local = Blog.fromJson(l.data);
    }, (r) {
      debugPrint(r.message);
    });
    return local;
  }

  Future<User?> getAuthor(int id) async {
    final response = await _baseApi.get(ApiRoutes.postUser + "$id");
    User? local;
    response.fold((l) {
      local = User.fromJson(l.data);
    }, (r) {
      debugPrint(r.message);
    });
    return local;
  }
}
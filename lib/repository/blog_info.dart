import 'package:flutter/material.dart';
import 'package:trishaheed/model/blog.dart';
import 'package:trishaheed/services/BaseApi.dart';
import 'package:trishaheed/utilities/api_routes.dart';

class BlogApi {
  Future<List<Blog>> getBlogList() async {
    final response = await BaseApi.createDio().get(ApiRoutes.posts);
    List<Blog> blogs = <Blog>[];
    response.fold((l) {
      for (var element in l.data) {
        final item = Blog.fromJson(element);
        blogs.add(item);
      }
    }, (r) {
      debugPrint(r.message);
    });
    return blogs;
  }

  Future<Blog?> getBlogForId(int id) async {
    final response =
        await BaseApi.createDio().get(ApiRoutes.postDetail + "$id");
    Blog? local;
    response.fold((l) {
      local = l.data;
    }, (r) {
      debugPrint(r.message);
    });
    return local;
  }
}

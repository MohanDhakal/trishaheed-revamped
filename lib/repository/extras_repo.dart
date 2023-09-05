import 'package:flutter/cupertino.dart';
import '../model/smc_member.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';

class ExtrasRepo {
  Future<List<Member>?> getMember() async {
    final response = await BaseApi.createDio().get(ApiRoutes.members);
    List<Member> posts = <Member>[];
    response.fold((l) {
      for (var element in l.data) {
        posts.add(Member.fromJson(element));
      }
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return posts;
  }
}

import 'package:flutter/material.dart';
import 'package:trishaheed/services/BaseApi.dart';
import 'package:trishaheed/utilities/api_routes.dart';

class ContactRepo {
  Future<String?> addFeedback(Map<String, dynamic> data) async {
    final response = await BaseApi.createDio().post(data, ApiRoutes.feeback);
    String? sucessMsg;
    response.fold((l) {
      sucessMsg = l.data["message"];
    }, (r) {
      debugPrint("${r.message}");
    });
    return sucessMsg;
  }
}
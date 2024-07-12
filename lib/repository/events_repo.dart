import 'package:flutter/widgets.dart';
import '../model/SchoolEvent.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';

class EventsRepo {
  Future<List<SchoolEvent>> getEvents() async {
    final response = await BaseApi.createDio().get(ApiRoutes.events);
    List<SchoolEvent> posts = <SchoolEvent>[];
    response.fold((l) {
      for (var element in l.data) {
        posts.add(SchoolEvent.fromMap(element));
      }
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return posts;
  }

}

import 'package:flutter/material.dart';
import 'package:trishaheed/repository/events_repo.dart';
import '../../utilities/latest_elements.dart';
import '../SchoolEvent.dart';

class EventState with ChangeNotifier {
  List<SchoolEvent> schoolEvents=[];
  
  Future<void> events() async {
    final EventsRepo staffRepo = EventsRepo();
    final allEvents = await staffRepo.getEvents();
    schoolEvents = getLatestElements(allEvents, 3);
    notifyListeners();
  }
}

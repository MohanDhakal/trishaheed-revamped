import 'package:flutter/foundation.dart';
import 'package:trishaheed/model/major_contact.dart';
import 'package:trishaheed/repository/staff_repo.dart';
import 'package:trishaheed/utilities/latest_elements.dart';

class StaffState with ChangeNotifier {
  List<MajorContact> staffs = <MajorContact>[];

  Future<void> contacts() async {
    final StaffRepo staffRepo = StaffRepo();
    final contacts = await staffRepo.getMajorContacts();
    staffs = getLatestElements(contacts, 3);
    notifyListeners();
  }
}

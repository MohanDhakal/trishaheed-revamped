import 'package:flutter/foundation.dart';
import 'package:trishaheed/model/staff.dart';
import '../model/major_contact.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';

class StaffRepo {
  Future<StaffDetail?> getStaffList({int page = 1}) async {
    final response =
        await BaseApi.createDio().get(ApiRoutes.staffs, {"page": page});
    StaffDetail? staffDetail;
    response.fold((l) {
      staffDetail = StaffDetail.fromJson(l.data);
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return staffDetail;
  }
    Future<Staff?> getStaffWithId(int id) async {
    final response =
        await BaseApi.createDio().get(ApiRoutes.staffDetail + "$id");
    Staff? local;
    response.fold((l) {
      local = Staff.fromJson(l.data);
    }, (r) {
      print("error occured");
      debugPrint(r.message);
    });
    return local;
  }
    Future<List<MajorContact>> getMajorContacts() async {
    List<MajorContact> tList = <MajorContact>[];
    BaseApi baseApi = BaseApi.createDio();
    var response = await baseApi.get(ApiRoutes.majorContacts);
    response.fold((l) {
      for (var element in l.data) {
        tList.add(MajorContact.fromMap(element));
      }
    }, (r) {
      print("Error with code: ${r.code} and message: ${r.message}");
    });
    return tList;
  }

}

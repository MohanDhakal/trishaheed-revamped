import 'package:flutter/foundation.dart';
import 'package:trishaheed/model/staff.dart';
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
  
}

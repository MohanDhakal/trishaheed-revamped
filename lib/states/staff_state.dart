import 'package:trishaheed/model/staff.dart';

class SharedStaff {
  Staff _staffDetail;
  SharedStaff(this._staffDetail);
  set staffDetail(Staff stf) {
    _staffDetail = stf;
  }

  get StaffDetail => _staffDetail;
}

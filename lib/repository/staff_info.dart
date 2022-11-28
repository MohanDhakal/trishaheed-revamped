import 'package:trishaheed/model/staff.dart';
import 'package:trishaheed/utilities/button_position.dart';

class StaffApi {
  Future<List<Staff>> getStaffList() async {
    List<Staff> staffList = [];
    for (var i = 1; i < 7; i++) {
      if (i < 5) {
        staffList.add(Staff(
          i,
          1,
          "मोहन कुमार ढकाल $i",
          "Secondary",
          "Java Programming",
          Position.passive,
        ));
      } else {
        staffList.add(Staff(
          i,
          2,
          "मोहन ढकाल $i",
          "Secondary",
          "Java Programming",
          Position.passive,
        ));
      }
    }
    return staffList;
  }
}

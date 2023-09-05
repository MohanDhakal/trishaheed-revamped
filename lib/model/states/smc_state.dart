import 'package:flutter/material.dart';
import '../../repository/extras_repo.dart';
import '../../utilities/member_type.dart';
import '../smc_member.dart';

enum SelectedMember { SMC, TPC }

class SmcState with ChangeNotifier {
  List<Member> smcs = [];
  List<Member> tpcs = [];
  bool loading = true;
  SelectedMember _selectedMember = SelectedMember.SMC;
  SelectedMember get selectedMember => _selectedMember;
  set selectedMember(SelectedMember member) {
    _selectedMember = member;
    notifyListeners();
  }

  Future<void> getMembers() async {
    final response = await ExtrasRepo().getMember();
    if (response != null) {
      List<Member> localsmcs = [];
      List<Member> localtpcs = [];
      for (var element in response) {
        if (element.memberType == MemberType.smc) {
          localsmcs.add(element);
        } else {
          localtpcs.add(element);
        }
      }
      smcs = localsmcs;
      tpcs = localtpcs;
    }
    loading = false;
    notifyListeners();
  }

  SmcState() {
    getMembers();
  }
}

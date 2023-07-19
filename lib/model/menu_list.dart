import 'package:flutter/cupertino.dart';
import 'package:trishaheed/model/menu_content.dart';
import '../utilities/menu_tag.dart';

class MenuList extends ChangeNotifier {
  List<MenuContent> menuList = [];

  void update(MenuContent content, int atIndex) {
    menuList[atIndex] = content;
    notifyListeners();
  }

  Future<void> prepareMenuList() async {
    for (var element in MenuTag.values) {
      menuList.add(
        MenuContent(
          menuTag: element,
          name: element.toString(),
          selected: false,
        ),
      );
    }
    notifyListeners();
  }
}

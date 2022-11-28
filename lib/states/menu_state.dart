import 'package:flutter/cupertino.dart';

import '../utilities/menu_tag.dart';

class MenuState extends ChangeNotifier {
  MenuTag selectedMenu = MenuTag.home;
  set changeMenu(MenuTag menu) {
    selectedMenu = menu;
    notifyListeners();
  }
}

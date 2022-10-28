import 'package:trishaheed/utilities/menu_tag.dart';

class MyAppConfiguration {
  final MenuTag? menuTag;
  MyAppConfiguration.home(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.photoGallery(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.staff(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.staffDetail(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.students(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.results(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.routine(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.videoGallery(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.extras(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.contact(MenuTag menu) : menuTag = menu;
  MyAppConfiguration.unknown() : menuTag = null;

  bool get homePage => menuTag == MenuTag.home;
  bool get imageGallery => menuTag == MenuTag.photoGallery;
  bool get staffPage => menuTag == MenuTag.staff;
  bool get students => menuTag == MenuTag.students;
  bool get videoGallery => menuTag == MenuTag.videoGallery;
  bool get results => menuTag == MenuTag.results;
  bool get routine => menuTag == MenuTag.routine;
  bool get extras => menuTag == MenuTag.extras;
  bool get contact => menuTag == MenuTag.contact;

  bool get unknown => menuTag == MenuTag.unknown;
}

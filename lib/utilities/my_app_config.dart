import 'package:trishaheed/utilities/menu_tag.dart';

class MyAppConfiguration {
  final MenuTag menuTag;
  MyAppConfiguration.home() : menuTag = MenuTag.home;
  MyAppConfiguration.photoGallery() : menuTag = MenuTag.photoGallery;
  MyAppConfiguration.staff() : menuTag = MenuTag.staff;
  MyAppConfiguration.students() : menuTag = MenuTag.students;
  MyAppConfiguration.downloads() : menuTag = MenuTag.downloads;
  MyAppConfiguration.videoGallery() : menuTag = MenuTag.videoGallery;
  MyAppConfiguration.extras() : menuTag = MenuTag.extras;
  MyAppConfiguration.contact() : menuTag = MenuTag.contact;
  MyAppConfiguration.unknown() : menuTag = MenuTag.unknown;

  bool get homePage => menuTag == MenuTag.home;
  bool get imageGallery => menuTag == MenuTag.photoGallery;
  bool get staffPage => menuTag == MenuTag.staff;
  bool get students => menuTag == MenuTag.students;
  bool get videoGallery => menuTag == MenuTag.videoGallery;
  bool get downloads => menuTag == MenuTag.downloads;
  bool get extras => menuTag == MenuTag.extras;
  bool get contact => menuTag == MenuTag.contact;

  bool get unknown => menuTag == MenuTag.unknown;
}

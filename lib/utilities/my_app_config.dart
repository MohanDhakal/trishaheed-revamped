import 'package:trishaheed/utilities/menu_tag.dart';
import 'package:trishaheed/utilities/results.dart';

class MyAppConfiguration {
  MenuTag? menuTag;
  int? id;
  int? staffId;
  String? external;
  MyAppConfiguration.home() : menuTag = MenuTag.home;
  MyAppConfiguration.photoGallery() : menuTag = MenuTag.photoGallery;
  MyAppConfiguration.staff() : menuTag = MenuTag.staff;
  MyAppConfiguration.students() : menuTag = MenuTag.students;
  MyAppConfiguration.downloads() : menuTag = MenuTag.downloads;
  // MyAppConfiguration.videoGallery() : menuTag = MenuTag.videoGallery;
  MyAppConfiguration.extras() : menuTag = MenuTag.extras;
  MyAppConfiguration.contact() : menuTag = MenuTag.contact;
  MyAppConfiguration.blog() : menuTag = MenuTag.blog;
  MyAppConfiguration.blogDetail(this.id) : menuTag = MenuTag.blogDetail;
  MyAppConfiguration.staffDetail(this.staffId) : menuTag = MenuTag.staffDetail;
  MyAppConfiguration.unknown() : menuTag = MenuTag.unknown;
  MyAppConfiguration.result() : external = Result.path;

  bool get homePage => menuTag == MenuTag.home;
  bool get imageGallery => menuTag == MenuTag.photoGallery;
  bool get staffPage => menuTag == MenuTag.staff;
  bool get students => menuTag == MenuTag.students;
  // bool get videoGallery => menuTag == MenuTag.videoGallery;
  bool get downloads => menuTag == MenuTag.downloads;
  bool get extras => menuTag == MenuTag.extras;
  bool get contact => menuTag == MenuTag.contact;
  bool get blog => menuTag == MenuTag.blog;
  bool get blogDetail => menuTag == MenuTag.blogDetail;
  bool get staffDetail => menuTag == MenuTag.staffDetail;
  bool get unknown => menuTag == MenuTag.unknown;
  bool get result => external == Result.path;

}

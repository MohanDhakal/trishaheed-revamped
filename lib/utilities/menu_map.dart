import 'package:trishaheed/utilities/menu_tag.dart';

class MenuIndex {
  static Map<MenuTag, int> map = {
    MenuTag.home: 0,
    MenuTag.photoGallery: 1,
    MenuTag.staff: 2,
    MenuTag.students: 3,
    MenuTag.videoGallery: 4,
    MenuTag.downloads: 5,
    MenuTag.extras: 6,
    MenuTag.contact: 7,
    MenuTag.blog: 8,
    MenuTag.blogDetail: 9,
    MenuTag.unknown: 10,
  };
  static Map<MenuTag, String> names = {
    MenuTag.home: "Home",
    MenuTag.photoGallery: "Photo Gallery",
    MenuTag.staff: "Staff",
    MenuTag.students: "Students",
    MenuTag.videoGallery: "Video Gallery",
    MenuTag.downloads: "Downloads",
    MenuTag.extras: "Extras",
    MenuTag.contact: "Contact Us",
    MenuTag.blog: "Blog",
  };
}

import 'package:trishaheed/utilities/menu_tag.dart';

class MenuIndex {
  static Map<MenuTag, int> map = {
    MenuTag.home: 0,
    MenuTag.photoGallery: 1,
    MenuTag.staff: 2,
    MenuTag.students: 3,
    // MenuTag.videoGallery: 4,
    MenuTag.downloads: 4,
    MenuTag.extras: 5,
    MenuTag.contact: 6,
    MenuTag.blog: 7,
    MenuTag.blogDetail: 8,
    MenuTag.staffDetail:9,
    MenuTag.unknown: 10,
  };
  static Map<MenuTag, String> names = {
    MenuTag.home: "Home",
    MenuTag.photoGallery: "Photo Gallery",
    MenuTag.staff: "Teacher Staff",
    MenuTag.students: "Students",
    // MenuTag.videoGallery: "Video Gallery",
    MenuTag.downloads: "Downloads",
    MenuTag.extras: "Extras",
    MenuTag.contact: "Contact Us",
    MenuTag.blog: "Blog",
  };
}

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
    MenuTag.home: "गृहपृष्ठ",
    MenuTag.photoGallery: "फोटो ग्यालरी",
    MenuTag.staff: "शिक्षक कर्मचारी",
    MenuTag.students: "विद्यार्थी",
    MenuTag.videoGallery: "भिडियो ग्यालरी",
    MenuTag.downloads: "डाउन्लोड्स",
    MenuTag.extras: "अन्य",
    MenuTag.contact: "सम्पर्क",
    MenuTag.blog: "बल्ग",
  };
}

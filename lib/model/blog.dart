import 'package:trishaheed/utilities/button_position.dart';

class Blog {
  int id;
  String date;
  String slug;
  String byWhom;
  String title;
  String content;
  String imageUri;
  Position position;
  Blog({
    required this.id,
    required this.date,
    required this.slug,
    required this.byWhom,
    required this.title,
    required this.content,
    required this.imageUri,
    required this.position,
  });
}

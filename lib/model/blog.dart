import 'package:flutter_quill/flutter_quill.dart';
import 'package:trishaheed/model/slugs.dart';
import 'package:trishaheed/utilities/button_position.dart';

class Blog {
  int id;
  String createdAt;
  List<Slug> slug;
  String byWhom;
  String title;
  Delta content;
  String imageUri;
  Position position;
  Blog({
    required this.id,
    required this.createdAt,
    required this.slug,
    required this.byWhom,
    required this.title,
    required this.content,
    required this.imageUri,
    required this.position,
  });

  factory Blog.fromJson(Map<String, dynamic> obj) {
    List<Slug> s = <Slug>[];

    for (var slug in obj["slugs"]) {
      s.add(Slug.fromJson(slug));
    }
    return Blog(
      title: obj["title"],
      content: Delta.fromJson(obj["body"]),
      byWhom: obj["user_id"].toString(),
      id: obj["post_id"],
      imageUri: obj["cover_image"],
      slug: s,
      createdAt: obj["updated_at"],
      position: Position.passive,
    );
  }
}

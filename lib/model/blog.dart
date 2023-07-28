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
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "createdAt": this.createdAt,
      "title": this.title,
      "delta": this.content.toJson(),
      "author": this.byWhom,
      "slugs": this.slug,
    };
  }

  factory Blog.fromJson(Map<String, dynamic> obj) {
    List<Slug> s = <Slug>[];
    // print(obj["slugs"]);
    for (var slug in obj["slugs"]) {
      s.add(Slug.fromJson(slug));
    }
    print(s);
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

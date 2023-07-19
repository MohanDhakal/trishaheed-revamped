import 'package:trishaheed/model/blog.dart';
import 'package:trishaheed/utilities/blog_data.dart';
import '../utilities/button_position.dart';
import '../utilities/images.dart';

class BlogApi {
  Future<List<Blog>> getBlogList() async {
    final blogList = List.generate(
      6,
      (index) => Blog(
        date: "August $index, 2022",
        id: index,
        byWhom: "By Mohan Dhakal and Shreya Shrestha",
        slug: "SLUG HERE $index",
        title: "What is BLoC ? What is BLoC ?What is BLoC ? ?What is BLoC ? ",
        content: blogContent,
        imageUri: potraitSample,
        position: Position.passive,
      ),
    );
    return blogList;
  }

  Future<Blog> getBlogForId(int id) async {
    final myBlog = Blog(
      date: "August $id, 2022",
      id: id,
      byWhom: "By Mohan Dhakal and Shreya Shrestha",
      slug: "SLUG HERE $id",
      title: "What is BLoC ? What is BLoC ?What is BLoC ? ?What is BLoC ? ",
      content: blogContent,
      imageUri: potraitSample,
      position: Position.passive,
    );
    return myBlog;
  }
}

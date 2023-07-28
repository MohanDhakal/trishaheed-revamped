import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/blog.dart';
import 'package:trishaheed/repository/blog_info.dart';
import 'package:trishaheed/utilities/button_position.dart';
import 'package:trishaheed/utilities/menu_tag.dart';

class BlogList extends StatefulWidget {
  final Function(MenuTag menuTag, int? id, Blog? blog) onClick;
  const BlogList({Key? key, required this.onClick}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  List<Blog> blogList = <Blog>[];
  bool _loadingBlog = false;
  @override
  void initState() {
    super.initState();
    BlogApi().getBlogList().then((value) {
      setState(() {
        blogList = value;
        _loadingBlog = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return _loadingBlog == false
        ? Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : blogList.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: Text("There are no blogs available at the moment"),
              )
            : GridView.builder(
                itemCount: blogList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onHover: ((value) {
                      setState(() {
                        if (blogList[index].position == Position.passive) {
                          blogList[index].position = Position.hovered;
                        } else {
                          blogList[index].position = Position.passive;
                        }
                      });
                    }),
                    onTap: () => widget.onClick(
                      MenuTag.blogDetail,
                      blogList[index].id,
                      blogList[index],
                    ),
                    child: SingleBlog(
                      blog: blogList[index],
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: responsiveWrapper.isLargerThan(TABLET)
                      ? responsiveWrapper.screenWidth * 0.4
                      : responsiveWrapper.screenWidth,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              );
  }
}

class SingleBlog extends StatelessWidget {
  final Blog blog;
  const SingleBlog({Key? key, required this.blog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              blog.imageUri,
              fit: BoxFit.fitWidth,
              height: responsiveWrapper.screenHeight * 0.3,
              width: responsiveWrapper.isLargerThan(TABLET)
                  ? responsiveWrapper.screenWidth * 0.4
                  : responsiveWrapper.screenWidth,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    blog.slug.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          blog.slug.elementAt(index).name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  blog.createdAt.substring(0, 9),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 4),
              Text(
                "Author ID",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  blog.byWhom,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              blog.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: blog.position == Position.hovered
                    ? Colors.orangeAccent
                    : null,
              ),
              maxLines: 3,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: responsiveWrapper.isLargerThan(TABLET)
                  ? responsiveWrapper.screenWidth * 0.4
                  : responsiveWrapper.screenWidth,
              child: Text(
                blog.content.first.data.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

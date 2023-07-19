import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:trishaheed/repository/blog_info.dart';
import '../model/blog.dart';

class BlogDetail extends StatefulWidget {
  final int? id;
  final Blog? blog;
  const BlogDetail({Key? key, this.id, this.blog}) : super(key: key);

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  Blog? urlPost;

  bool _loading = true;
  @override
  void initState() {
    super.initState();
    if (widget.blog == null) {
      // print("blog null");
      BlogApi().getBlogForId(1).then((value) {
        urlPost = value;
      });
      setState(() {
        _loading = false;
      });
    } else {
      Future.delayed(
        Duration(
          seconds: 2,
        ),
      ).then((value) {
        setState(() {
          _loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return _loading
        ? Material(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Loading Details"),
                  CircularProgressIndicator(value: 24),
                ],
              ),
            ),
          )
        : Material(
            child: SingleChildScrollView(
              child: Container(
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
                      child: Image.asset(
                        widget.blog != null
                            ? widget.blog!.imageUri
                            : urlPost!.imageUri,
                        fit: BoxFit.cover,
                        height: responsiveWrapper.screenHeight * 0.6,
                        width: responsiveWrapper.screenWidth,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.blog != null
                                ? widget.blog!.slug
                                : urlPost!.slug,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.blog != null
                                ? widget.blog!.date
                                : urlPost!.date,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.blog != null
                            ? widget.blog!.byWhom
                            : urlPost!.byWhom,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.blog != null
                            ? widget.blog!.title
                            : urlPost!.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: responsiveWrapper.screenWidth,
                        child: Text(
                          widget.blog != null
                              ? widget.blog!.content
                              : urlPost!.content,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

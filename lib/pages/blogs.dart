import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trishaheed/model/blog.dart';
import 'package:trishaheed/repository/blog_info.dart';
import 'package:trishaheed/utilities/button_position.dart';
import 'package:trishaheed/utilities/menu_tag.dart';
import 'package:trishaheed/widgets/tags.dart';

class BlogList extends StatefulWidget {
  final Function(MenuTag menuTag, int? id, Blog? blog) onClick;
  const BlogList({Key? key, required this.onClick}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  List<Blog> blogList = <Blog>[];
  bool _loadingBlog = false;
  int _totalPages = 1;
  int _currentPage = 1;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlogApi().getBlogList().then((value) {
      setState(() {
        blogList = value.blogList;
        _totalPages = value.totalPages;
        _currentPage = value.currentPage;
        _loadingBlog = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return _loadingBlog == false
        ? Material(
            child: Shimmer.fromColors(
              baseColor: Colors.blueGrey.shade300,
              highlightColor: Colors.blueGrey.shade100,
              enabled: true,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: responsiveWrapper.isLargerThan(TABLET)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 16.0),
                              BannerPlaceholder(),
                              TitlePlaceholder(),
                              SizedBox(height: 16.0),
                            ],
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 16.0),
                              BannerPlaceholder(),
                              TitlePlaceholder(),
                              SizedBox(height: 16.0),
                            ],
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 16.0),
                              BannerPlaceholder(),
                              TitlePlaceholder(),
                              SizedBox(height: 16.0),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 16.0),
                          BannerPlaceholder(),
                          TitlePlaceholder(),
                          SizedBox(height: 16.0),
                          BannerPlaceholder(),
                          TitlePlaceholder(),
                        ],
                      ),
              ),
            ),
          )
        : blogList.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: Text("There are no blogs available at the moment"),
              )
            : RawKeyboardListener(
                focusNode: _focusNode,
                onKey: _handleKeyEvent,
                autofocus: true,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        title: Text("Switch Between Pages"),
                        backgroundColor: Colors.purple,
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: _currentPage < 2
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  if (_currentPage > 1) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Processing"),
                                            content: SizedBox(
                                              height: 36,
                                              width: 36,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                    BlogApi()
                                        .getBlogList(page: _currentPage - 1)
                                        .then((value) {
                                      Navigator.pop(context);
                                      setState(() {
                                        blogList = value.blogList;
                                        _totalPages = value.totalPages;
                                        _currentPage = value.currentPage;
                                      });
                                    });
                                  }
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                    "Page ${_currentPage} of ${_totalPages}"),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: _currentPage < _totalPages
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                                onPressed: () async {
                                  if (_currentPage < _totalPages) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Processing"),
                                          content: SizedBox(
                                            height: 36,
                                            width: 36,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                    BlogApi()
                                        .getBlogList(page: _currentPage + 1)
                                        .then(
                                      (value) {
                                        Navigator.pop(context);
                                        setState(
                                          () {
                                            blogList = value.blogList;
                                            _totalPages = value.totalPages;
                                            _currentPage = value.currentPage;
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ];
                  },
                  body: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: responsiveWrapper.screenHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: GridView.builder(
                              itemCount: blogList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onHover: ((value) {
                                    setState(() {
                                      if (blogList[index].position ==
                                          Position.passive) {
                                        blogList[index].position =
                                            Position.hovered;
                                      } else {
                                        blogList[index].position =
                                            Position.passive;
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
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    responsiveWrapper.isLargerThan(TABLET)
                                        ? responsiveWrapper.screenWidth * 0.4
                                        : responsiveWrapper.screenWidth,
                                childAspectRatio: 1,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    }
  }
}

class SingleBlog extends StatelessWidget {
  final Blog blog;
  const SingleBlog({Key? key, required this.blog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final content = blog.content.first.data.toString();
    final responsiveWrapper = ResponsiveWrapper.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
      margin: EdgeInsets.symmetric(horizontal: 12),
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
                        child: Tags(
                          name: blog.slug.elementAt(index).name,
                          index: index,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  blog.createdAt.substring(0, 10),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
          Row(
            children: [
              SizedBox(width: 4),
              Text(
                blog.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: responsiveWrapper.isLargerThan(TABLET)
                    ? responsiveWrapper.screenWidth * 0.4
                    : responsiveWrapper.screenWidth,
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: Text(
            "Title of the post",
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: Text(
            "body of the post loading....",
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: responsiveWrapper.isSmallerThan(DESKTOP)
          ? size.width * 0.8
          : size.width * 0.3,
      height: size.height * 0.4,
      color: Colors.green,
    );
  }
}

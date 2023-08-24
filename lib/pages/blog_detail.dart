import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trishaheed/repository/blog_info.dart';
import '../model/blog.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../widgets/tags.dart';

class BlogDetail extends StatefulWidget {
  final int? id;
  const BlogDetail({Key? key, this.id}) : super(key: key);

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _controller = ScrollController();
  String userName = "";
  bool _loading = true;
  quill.QuillController? _readOnlyContainer;
  Blog? _blogDetail;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      BlogApi().getBlogForId(widget.id!).then((blog) async {
        convertData(blog: blog).then((value) {
          setState(() {
            _loading = false;
            _blogDetail = blog;
          });
        });
      });
    }
  }

  Future<void> convertData({Blog? blog}) async {
    var list = blog!.content.toJson();
    list.add({"insert": '\n'});
    var convertedDelta = quill.Delta.fromJson(list);
    final document = quill.Document.fromDelta(convertedDelta);
    _readOnlyContainer = quill.QuillController(
      document: document,
      selection: TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;

    return _loading
        ? Material(
            child: Shimmer.fromColors(
              baseColor: Colors.blueGrey.shade300,
              highlightColor: Colors.blueGrey.shade100,
              enabled: true,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BannerPlaceholder(),
                    TitlePlaceholder(),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          )
        : (_blogDetail != null)
            ? Material(
                child: RawKeyboardListener(
                  focusNode: _focusNode,
                  onKey: _handleKeyEvent,
                  autofocus: true,
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 12.0,
                            ),
                            child: SelectableText(
                              _blogDetail!.title,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              _blogDetail!.imageUri,
                              fit: BoxFit.contain,
                              height: responsiveWrapper.screenHeight * 0.6,
                              width: responsiveWrapper.screenWidth,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    _blogDetail!.slug.length,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Tags(
                                          name: _blogDetail!.slug
                                              .elementAt(index)
                                              .name,
                                          index: index,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  _blogDetail!.createdAt.substring(0, 10),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(width: 4),
                              Text(
                                "Author: ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  userName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: quill.QuillEditor(
                              controller: _readOnlyContainer!,
                              scrollController: ScrollController(),
                              scrollable: true,
                              focusNode: FocusNode(),
                              autoFocus: false,
                              readOnly: true,
                              expands: false,
                              padding: EdgeInsets.zero,
                              minHeight: size.height,
                              keyboardAppearance: Brightness.light,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox();
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

class TitlePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      ),
      child: Text(
        "Post Content is loading please wait....",
        // overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 3,
      ),
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      color: Colors.green,
    );
  }
}

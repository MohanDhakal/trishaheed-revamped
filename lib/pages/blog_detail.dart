import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../model/blog.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class BlogDetail extends StatefulWidget {
  final int? id;
  final Blog? blog;
  const BlogDetail({Key? key, this.id, this.blog}) : super(key: key);

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  // Blog? urlPost;

  bool _loading = true;
  quill.QuillController? _readOnlyContainer;

  @override
  void initState() {
    super.initState();
    convertData().then((value) {
      setState(() {
        _loading = false;
      });
    });
    // if (widget.blog == null) {
    //   // print("blog null");
    //   BlogApi().getBlogForId(1).then((value) {
    //     urlPost = value;
    //   });
    //   setState(() {
    //     _loading = false;
    //   });
    // } else {
    //   Future.delayed(
    //     Duration(
    //       seconds: 2,
    //     ),
    //   ).then((value) {
    //     setState(() {
    //       _loading = false;
    //     });
    //   });
    // }
  }

  Future<void> convertData() async {
    if (widget.blog != null) {
      var convertedDelta = quill.Delta.fromJson(
        [
          {"insert": widget.blog!.content.first.data.toString() + '\n'},
        ],
      );
      final document = quill.Document.fromDelta(convertedDelta);
      _readOnlyContainer = quill.QuillController(
        document: document,
        selection: TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;

    return _loading
        ? Material(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Loading Details..."),
                  CircularProgressIndicator(value: 24),
                ],
              ),
            ),
          )
        : (widget.blog != null)
            ? Material(
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
                          child: Image.network(
                            widget.blog!.imageUri,
                            fit: BoxFit.cover,
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
                                  widget.blog!.slug.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Text(
                                        widget.blog!.slug.elementAt(index).name,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                widget.blog!.createdAt.substring(0, 10),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                widget.blog!.byWhom,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.blog!.title,
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
                            minHeight: size.height * 0.50,
                            // keyboardAppearance: Brightness.light,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox();
  }
}

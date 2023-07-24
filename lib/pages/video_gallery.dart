import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:webviewx/webviewx.dart';

class VideoGallery extends StatefulWidget {
  const VideoGallery({Key? key}) : super(key: key);

  @override
  State<VideoGallery> createState() => _VideoGalleryState();
}

class _VideoGalleryState extends State<VideoGallery> {
  late WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            "Video Category 1",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        SizedBox(height: 16),
        ResponsiveRowColumn(
          layout: responsiveWrapper.isSmallerThan(TABLET)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.center,
          columnMainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 20),
            ResponsiveRowColumnItem(
              child: WebViewX(
                initialContent:
                    'https://www.youtube.com/embed/8juaRClmTZo?start=119',
                initialSourceType: SourceType.url,
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                height: responsiveWrapper.isSmallerThan(TABLET)
                    ? size.height * 0.7
                    : size.height * 0.6,
                width: responsiveWrapper.isSmallerThan(TABLET)
                    ? size.width * 0.95
                    : size.width * 0.40,
              ),
            ),

            responsiveWrapper.isSmallerThan(TABLET)
                ? ResponsiveRowColumnItem(child: SizedBox(height: 20))
                : ResponsiveRowColumnItem(
                    child: SizedBox(
                      width: 20,
                    ),
                  ),
            ResponsiveRowColumnItem(
              child: WebViewX(
                initialContent:
                    'https://www.youtube.com/embed/8juaRClmTZo?start=119',
                initialSourceType: SourceType.url,
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                height: responsiveWrapper.isSmallerThan(TABLET)
                    ? size.height * 0.7
                    : size.height * 0.6,
                width: responsiveWrapper.isSmallerThan(TABLET)
                    ? size.width * 0.95
                    : size.width * 0.40,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

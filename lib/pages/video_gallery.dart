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
    return ListView(
      children: [
        SizedBox(height: 5),
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            "Video Category 1",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(height: 10),
        ResponsiveRowColumn(
          layout: responsiveWrapper.isSmallerThan(DESKTOP)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.spaceAround,
          columnMainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 20),
            ResponsiveRowColumnItem(
              child: WebViewX(
                initialContent:
                    'https://www.youtube.com/embed/8juaRClmTZo?start=119',
                initialSourceType: SourceType.url,
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                height: 350,
                width: 500,
              ),
            ),

            responsiveWrapper.isSmallerThan(DESKTOP)
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
                height: 350,
                width: 500,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            "Video Category 2",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(height: 10),
        ResponsiveRowColumn(
          layout: responsiveWrapper.isSmallerThan(DESKTOP)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.spaceAround,
          columnMainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 20),
            ResponsiveRowColumnItem(
              child: WebViewX(
                initialContent:
                    'https://www.youtube.com/embed/8juaRClmTZo?start=119',
                initialSourceType: SourceType.url,
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                height: 350,
                width: 500,
              ),
            ),
            responsiveWrapper.isSmallerThan(DESKTOP)
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
                height: 350,
                width: 500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

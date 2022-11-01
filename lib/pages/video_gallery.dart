import 'package:flutter/material.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SizedBox(height: 20),
            WebViewX(
              initialContent:
                  'https://www.youtube.com/embed/8juaRClmTZo?start=119',
              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) => webviewController = controller,
              height: 400,
              width: 500,
            ),
            SizedBox(width: 20),
            WebViewX(
              initialContent:
                  'https://www.youtube.com/embed/8juaRClmTZo?start=119',
              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) => webviewController = controller,
              height: 400,
              width: 500,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WebViewX(
              initialContent:
                  'https://www.youtube.com/embed/8juaRClmTZo?start=119',
              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) => webviewController = controller,
              height: 400,
              width: 500,
            ),
            SizedBox(width: 20),
            WebViewX(
              initialContent:
                  'https://www.youtube.com/embed/8juaRClmTZo?start=119',
              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) => webviewController = controller,
              height: 400,
              width: 500,
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

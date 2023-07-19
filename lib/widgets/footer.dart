import 'package:responsive_framework/responsive_framework.dart';
import 'package:webviewx/webviewx.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final Color? color;
  const FooterWidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebViewXController webviewController;
    final size = MediaQuery.of(context).size;

    return Container(
      color: color,
      padding: EdgeInsets.only(top: 20),
      child: ResponsiveRowColumn(
        layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        columnMainAxisAlignment: MainAxisAlignment.start,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.spaceAround,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        columnPadding: EdgeInsets.only(left: 24.0),
        children: [
          ResponsiveRowColumnItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                      ? size.width * 0.8
                      : size.width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "	Co-ordinates: 28.13°N 83.78°E, Panchamul-syangja, Gandaki Zone, Nepal",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "	+9779862790724",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "trishaheed1996@gmail.com",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Important Links",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.black,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Aandhikhola Rural Municipality",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.black,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Nepal Education Board ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(child: SizedBox(height: 24)),
          ResponsiveRowColumnItem(
            child: WebViewX(
              initialContent:
                  'https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%E0%A4%B6%E0%A5%8D%E0%A4%B0%E0%A5%80-%E0%A4%A4%E0%A5%8D%E0%A4%B0%E0%A4%BF-%E0%A4%B6%E0%A4%B9%E0%A5%80%E0%A4%A6-%E0%A4%AE%E0%A4%BE%E0%A4%B5%E0%A4%BF-%E0%A4%AA%E0%A4%9E%E0%A5%8D%E0%A4%9A%E0%A4%AE%E0%A5%81%E0%A4%B2-%E0%A4%86%E0%A4%82%E0%A4%A7%E0%A4%BF%E0%A4%96%E0%A5%8B%E0%A4%B2%E0%A4%BE-%E0%A5%A7-%E0%A4%B8%E0%A5%8D%E0%A4%AF%E0%A4%BE%E0%A4%99%E0%A5%8D%E0%A4%9C%E0%A4%BE--1393860857356600%2F&tabs=timeline&width=400&height=500&small_header=true&adapt_container_width=true&hide_cover=true&show_facepile=false&appId',
              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) => webviewController = controller,
              height: 500,
              width: 400,
            ),
          ),
          ResponsiveRowColumnItem(
            child: SizedBox(
              height: 15,
              child: Divider(
                height: 5,
              ),
            ),
          ),
          ResponsiveRowColumnItem(
            child: WebViewX(
              initialContent:
                  'https://www.hamropatro.com/widgets/dateconverter.php',
              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) => webviewController = controller,
              height: 200,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}

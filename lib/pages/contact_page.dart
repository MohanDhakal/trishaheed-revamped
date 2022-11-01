import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import '../utilities/textstyles.dart';
import '../widgets/complaint_form.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late WebViewXController webviewController;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              ComplaintForm(),
              SizedBox(
                width: size.width / 2,
                child: Container(
                  width: 150,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      "\"Send Your Message Directly to the authority, One of the teacher from our school will respond to your query and will forward message to the concerned party\"",
                      style: CustomTextStyle.formHeading(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                      .bodyText2
                                      ?.copyWith(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
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
                                    .bodyText2
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 24,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "trishaheed1997@gmail.com",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Important Links",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.black,
                      ),
                      Text(
                        "First Link",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.black,
                      ),
                      Text(
                        "Second Link",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              WebViewX(
                initialContent:
                    'https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%E0%A4%B6%E0%A5%8D%E0%A4%B0%E0%A5%80-%E0%A4%A4%E0%A5%8D%E0%A4%B0%E0%A4%BF-%E0%A4%B6%E0%A4%B9%E0%A5%80%E0%A4%A6-%E0%A4%AE%E0%A4%BE%E0%A4%B5%E0%A4%BF-%E0%A4%AA%E0%A4%9E%E0%A5%8D%E0%A4%9A%E0%A4%AE%E0%A5%81%E0%A4%B2-%E0%A4%86%E0%A4%82%E0%A4%A7%E0%A4%BF%E0%A4%96%E0%A5%8B%E0%A4%B2%E0%A4%BE-%E0%A5%A7-%E0%A4%B8%E0%A5%8D%E0%A4%AF%E0%A4%BE%E0%A4%99%E0%A5%8D%E0%A4%9C%E0%A4%BE--1393860857356600%2F&tabs=timeline&width=400&height=500&small_header=true&adapt_container_width=true&hide_cover=true&show_facepile=false&appId',
                initialSourceType: SourceType.url,
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                height: 500,
                width: 400,
              ),
              WebViewX(
                initialContent:
                    'https://www.hamropatro.com/widgets/dateconverter.php',
                initialSourceType: SourceType.url,
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                height: 200,
                width: 300,
              ),
            ],
          )
        ],
      ),
    );
  }
}

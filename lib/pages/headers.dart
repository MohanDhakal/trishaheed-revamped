import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../utilities/images.dart';

class FixHeader extends StatelessWidget {
  final Function() onNewNotice;
  final Function() onHome;
  const FixHeader({
    Key? key,
    required this.onNewNotice,
    required this.onHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onHome,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                logo,
                width: 100,
                height: 100,
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              text: "श्री त्रि-शहिद",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
              children: [
                TextSpan(
                  text: "\nनमुना मा.वि",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(width: 80),
          Row(
            children: [
              Image.asset(
                paperPlane,
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              SelectableText(
                "Email: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SelectableText(
                "trishaheed1986@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.largerThan(name: TABLET),
                ],
                child: SizedBox(
                  width: size.width * 0.1,
                ),
              ),
              Image.asset(
                telephone,
                width: 20,
                height: 20,
              ),
              ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.largerThan(name: TABLET),
                ],
                child: SizedBox(width: 10),
              ),
              SelectableText(
                "Call: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SelectableText(
                "9846095574",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.largerThan(name: TABLET),
                ],
                child: SizedBox(width: size.width * 0.1),
              ),
            ],
          ),
          InkWell(
            onTap: onNewNotice,
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(2),
              ),
              alignment: Alignment.center,
              child: Text("New Notice"),
              width: 100,
              height: 50,
            ),
          )
        ],
      ),
    );
  }
}

class HeaderForMobile extends StatelessWidget {
  final Function() onNewNotice;
  final Function() onHome;

  const HeaderForMobile(
      {Key? key, required this.onNewNotice, required this.onHome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onHome,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    logo,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        telephone,
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 10),
                      SelectableText(
                        "Call: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 10),
                      SelectableText(
                        "9846095574",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        paperPlane,
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Email: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "trishaheed1986@gmail.com",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: onNewNotice,
                    child: Container(
                      height: 50,
                      width: size.width * 0.5,
                      margin: EdgeInsets.only(
                          left: 10, bottom: 5, top: 5, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      alignment: Alignment.center,
                      child: Text("New Notice"),
                    ),
                  ),
                ],
              ),

              // Text.rich(
              //   TextSpan(
              //     text: "श्री त्रि-शहिद",
              //     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black,
              //         ),
              //     children: [
              //       TextSpan(
              //         text: "\nनमुना मा.वि",
              //         style: Theme.of(context)
              //             .textTheme
              //             .headlineSmall
              //             ?.copyWith(fontWeight: FontWeight.bold),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

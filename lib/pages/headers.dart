import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utilities/images.dart';

class FixHeader extends StatelessWidget {
  final Function() onNewNotice;
  final Function() onHome;
  final Function() onResultsPublished;

  const FixHeader({
    Key? key,
    required this.onNewNotice,
    required this.onHome,
    required this.onResultsPublished,
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
                width: 80,
                height: 80,
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
            onTap: onResultsPublished,
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(2),
              ),
              alignment: Alignment.center,
              child: Text("View Results"),
              width: 100,
              height: 50,
            ),
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
  final Function() onResultsPublished;

  const HeaderForMobile(
      {Key? key,
      required this.onNewNotice,
      required this.onHome,
      required this.onResultsPublished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h),
          SizedBox(
            width: Adaptive.w(100),
            height: 13.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: onHome,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      logo,
                      width: Adaptive.w(15),
                      height: 15.h,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SelectableText(
                        "Shree Tri-Shaheed Model Secondary School, Aandhikhola-1 ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.deepPurple),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            telephone,
                            width: 16.sp,
                            height: 16.sp,
                          ),
                          SizedBox(width: 8),
                          SelectableText(
                            "Call: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.deepPurpleAccent),
                          ),
                          SizedBox(width: 8),
                          SelectableText(
                            "9846095574",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            paperPlane,
                            width: 16.sp,
                            height: 16.sp,
                          ),
                          SizedBox(width: 8.sp),
                          Text(
                            "Email: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.deepPurpleAccent),
                          ),
                          Text(
                            "trishaheed1986@gmail.com",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: onNewNotice,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "NEW NOTICE",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black87
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: onResultsPublished,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "SEE RESULT",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(width: 4.sp),
                      Icon(Icons.login),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.sp,
          ),
        ],
      ),
    );
  }
}

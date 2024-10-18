import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utilities/images.dart';

class FixHeader extends StatefulWidget {
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
  State<FixHeader> createState() => _FixHeaderState();
}

class _FixHeaderState extends State<FixHeader> with TickerProviderStateMixin {



  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(begin: Colors.greenAccent, end: Colors.orangeAccent)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reverse();
      }
      if (_controller.isDismissed) {
        _controller.forward();
      }
    });
    Future.delayed(Duration(seconds: 1)).then((value) {
      _controller.forward();
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: widget.onHome,
            child: Padding(
              padding: const EdgeInsets.all(8),
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
          SizedBox(width: 64),
          Row(
            children: [
              Image.asset(
                paperPlane,
                width: 32,
                height: 32,
              ),
              SizedBox(width: 8),
              SelectableText(
                "Email: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SelectableText(
                "trishaheed1986@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 48),
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
          AnimatedBuilder(
              animation: _controller,
              builder: (context, value) {
                return InkWell(
                  onTap: widget.onResultsPublished,
                  child: Container(
                    margin: EdgeInsets.only(right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(4),
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [
                            _colorAnimation.value ?? Colors.transparent,
                            _colorAnimation.value ?? Colors.transparent
                          ],
                        ),
                        width: 4,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text("See Results"),
                    width: 96,
                    height: 48,
                  ),
                );
              }),
          AnimatedBuilder(
              animation: _controller,
              child: Text("New Notice"),
              builder: (context, child) {
                return InkWell(
                  onTap: widget.onNewNotice,
                  child: Container(
                    margin: EdgeInsets.only(right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [
                            _colorAnimation.value ?? Colors.transparent,
                            _colorAnimation.value ?? Colors.transparent
                          ],
                        ),
                        width: 4,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: child,
                    width: 96,
                    height: 48,
                  ),
                );
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

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
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
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
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: onResultsPublished,
                        child: Container(
                          height: 48,
                          width: 100,
                          margin: EdgeInsets.only(
                              left: 10, bottom: 5, top: 5, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          alignment: Alignment.center,
                          child: Text("Exam Result"),
                        ),
                      ),
                      MaterialButton(
                        onPressed: onNewNotice,
                        child: Container(
                          height: 48,
                          width: 100,
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
                ],
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

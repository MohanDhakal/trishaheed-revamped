import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/utilities/images.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Highlights extends StatefulWidget {
  final String imageUri;
  final String? title;
  final String? detail;
  final Color backgroundColor;
  const Highlights({
    Key? key,
    this.title,
    this.backgroundColor = const Color.fromRGBO(255, 85, 0, 0.961),
    this.detail,
    this.imageUri = progressIcon,
  }) : super(key: key);

  @override
  State<Highlights> createState() => _HighlightsState();
}

class _HighlightsState extends State<Highlights> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween(begin: 50.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    ));
    _rotationAnimation = Tween(begin: -pi, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wrapper = ResponsiveWrapper.of(context);
    return VisibilityDetector(
      key: Key('highlights ${widget.title}'),
      onVisibilityChanged: (VisibilityInfo info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage > 1) {
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // final isHalfway = _animation.value > 0.5;
            final position = _animation.value;
            final angle = _rotationAnimation.value;
            final transform = Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(
                position,
                position,
              )
              ..rotateX(angle);
            return Transform(
              transform: transform,
              alignment: Alignment.bottomLeft,
              child: Container(
                width: wrapper.isSmallerThan(DESKTOP)
                    ? size.width * 0.8
                    : size.width / 3,
                height: wrapper.isSmallerThan(DESKTOP)
                    ? size.height * 0.4
                    : size.height * 0.5,
                decoration: BoxDecoration(color: widget.backgroundColor),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Image.asset(
                      widget.imageUri,
                      width: 36,
                      height: 36,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.title ?? "TITLE HERE",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 36),
                    Text(
                      widget.detail ?? "DETAIL HERE",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            height: 1.5,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

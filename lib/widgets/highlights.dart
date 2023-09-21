import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/utilities/images.dart';

class Highlights extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wrapper = ResponsiveWrapper.of(context);
    return Container(
      width: wrapper.isSmallerThan(DESKTOP) ? size.width * 0.8 : size.width / 3,
      height: wrapper.isSmallerThan(DESKTOP)
          ? size.height * 0.4
          : size.height * 0.5,
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.asset(
            imageUri,
            width: 36,
            height: 36,
            color: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title ?? "TITLE HERE",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 36,
          ),
          Text(
            detail ?? "DETAIL HERE",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  height: 1.5,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}

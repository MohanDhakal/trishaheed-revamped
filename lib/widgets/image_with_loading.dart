import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class ImageWithLoading extends StatefulWidget {
  final String imageUrl;
  ImageWithLoading({required this.imageUrl});

  @override
  _ImageWithLoadingState createState() => _ImageWithLoadingState();
}

class _ImageWithLoadingState extends State<ImageWithLoading> {
  //As the server does not provide

  //the bytes transferred we cannot use
  //range header in Network.Image hence we cannot get
  //the bytes received and show progress in percentage

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return Stack(
      children: <Widget>[
        Image.network(
          widget.imageUrl,
          fit: BoxFit.fitHeight,
          height: size.height * 0.8,
          width: responsiveWrapper.isSmallerThan(DESKTOP)
              ? size.width * 0.95
              : size.width * 0.8,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green.shade200,
                valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            );
          },
          frameBuilder: (BuildContext context, Widget child, int? frame,
              bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            if (frame == null) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            print(stackTrace);
            return Center(child: Text("Error loading image"));
          },
        ),
      ],
    );
  }
}

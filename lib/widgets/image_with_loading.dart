import 'package:cached_network_image/cached_network_image.dart';
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
        CachedNetworkImage(
          imageUrl: widget.imageUrl,
          fit: BoxFit.contain,
          height: responsiveWrapper.isSmallerThan(TABLET)
              ? size.height * 0.5
              : size.height * 0.8,
          width: responsiveWrapper.isSmallerThan(TABLET)
              ? size.width * 0.95
              : size.width * 0.8,
          progressIndicatorBuilder: (BuildContext context, String child,
              DownloadProgress downloadProgress) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: downloadProgress
                      .progress, // Shows the current download progress
                  strokeWidth: 4.0,
                  color: Colors.blue,
                ),
                Text(
                  '${(double.parse(downloadProgress.progress?.toStringAsFixed(1) ?? '0')) * 100}%',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          },
          errorWidget: (context, error, stackTrace) {
            return Center(child: Text("Error loading image"));
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../widgets/image_with_loading.dart';

class ImageDialog extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  ImageDialog({required this.imageUrls, this.initialIndex = 0});

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  int? _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return _currentIndex == null
        ? Center(
            child: Text("Something went wrong"),
          )
        : Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              width: responsiveWrapper.isSmallerThan(DESKTOP)
                  ? size.width
                  : size.width * 0.7,
              height: size.height * 0.86,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ImageWithLoading(
                      imageUrl: widget.imageUrls[_currentIndex!],
                    ),
                  ),
                  Container(
                    color: Colors.blueAccent,
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.navigate_before,size: 36,),
                          onPressed: _currentIndex! > 0
                              ? () {
                                  setState(() {
                                    _currentIndex = _currentIndex! - 1;
                                  });
                                }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next,size: 36,),
                          onPressed:
                              _currentIndex! < widget.imageUrls.length - 1
                                  ? () {
                                      setState(() {
                                        _currentIndex = _currentIndex! + 1;
                                      });
                                    }
                                  : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

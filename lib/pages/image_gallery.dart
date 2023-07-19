import 'package:flutter/material.dart';
import 'package:trishaheed/widgets/image_folder.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        return ImageFolder();
      }),
      itemCount: 4,
    );
  }
}

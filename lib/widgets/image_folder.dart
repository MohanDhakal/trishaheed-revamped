import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageFolder extends StatelessWidget {
  const ImageFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10),
          child: Text("First Image Section"),
        ),
        CarouselSlider(
          options: CarouselOptions(height: 400.0),
          items: [1, 2].map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

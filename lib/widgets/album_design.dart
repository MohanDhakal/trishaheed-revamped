import 'package:flutter/material.dart';
import '../model/albums.dart' as model;

class Album extends StatelessWidget {
  final model.Album album;
  const Album({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.blueAccent,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                album.name,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${album.description}",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

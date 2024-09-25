import 'package:flutter/material.dart';
import '../model/albums.dart' as model;

class Album extends StatelessWidget {
  final model.Album album;
  const Album({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the card
      child: Center(
        child: Material(
          elevation: 8.0, // Add shadow for a raised effect
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background with gradient and border radius
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              // Album content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Album title with enhanced style
                          Text(
                            album.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28, // Larger font size
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2, // Add some letter spacing
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              
                            ),
                          ),
                          SizedBox(
                              height: 8.0), // Spacing between title and description
                          // Album description with improved readability
                          Text(
                            "${album.description}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                      
                              fontSize: 18,
                              height: 1.4, // Increase line height for readability
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

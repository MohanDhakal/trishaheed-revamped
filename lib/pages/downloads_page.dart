import 'package:flutter/material.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(width: screenWidth * 0.025),
        Container(
          width: screenWidth * 0.25,
          child: Column(
            children: [
              SizedBox(height: screenWidth * 0.025),
              Container(
                height: screenWidth * 0.05,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Section 1",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.deepPurpleAccent,
                ),
              ),
              Container(
                height: screenWidth * 0.05,
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Section 2",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.deepPurpleAccent,
                ),
              ),
              Container(
                height: screenWidth * 0.05,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Section 3",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.deepPurpleAccent,
                ),
              )
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.025),
        Container(
          width: screenWidth * 0.7,
          padding: EdgeInsets.only(left: 5),
          margin: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenWidth * 0.025),
              Text(
                "First Link of the file to download",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "second Link of the file to download",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "third Link of the file to download",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

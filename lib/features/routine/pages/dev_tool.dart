import 'package:flutter/material.dart';

class DevToolPractice extends StatelessWidget {
  const DevToolPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Text Data",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                 Text(
                  "Name",
                ), Text(
                  "phone Number",
                ),
                Text(
                  "Hello this is for testing purpose and I am doing nothing to improve this text side",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

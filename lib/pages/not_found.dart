import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  final String text;
  const UnknownPage({Key? key, this.text = "This is the 404 Page "})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text(text)),
    );
  }
}

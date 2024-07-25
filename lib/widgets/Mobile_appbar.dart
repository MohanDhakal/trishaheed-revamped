import 'package:flutter/material.dart';

class MobileAppBar extends StatelessWidget {
  final void Function() onMenuPressed;
  const MobileAppBar({super.key,required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Colors.blueAccent,
      elevation: 4,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          size: 24,
          color: Colors.black,
        ),
        onPressed:onMenuPressed
      ),
      title: SelectableText(
        "TRI-SHAHEED SCHOOL APP",
        style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

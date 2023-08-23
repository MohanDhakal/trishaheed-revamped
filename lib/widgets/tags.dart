import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  final String name;
  final int index;
  const Tags({super.key, required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: index.isEven ? Colors.blue : Colors.purpleAccent,
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

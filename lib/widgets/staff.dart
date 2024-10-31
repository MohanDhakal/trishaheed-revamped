import 'package:flutter/material.dart';
import 'package:trishaheed/model/staff.dart' as s;
import 'package:trishaheed/utilities/images.dart';

class Staff extends StatelessWidget {
  final bool isStatic;
  final s.Staff staff;
  const Staff({
    required this.staff,
    this.isStatic = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.purpleAccent,
          width: 4,
        ),
        boxShadow: staff.onFocused ?? false
            ? [
                BoxShadow(
                  blurRadius: 8.0,
                  spreadRadius: 8.0,
                  color: Colors.black12,
                )
              ]
            : null,
        gradient: LinearGradient(
          colors: [Color(0xFFEAAECA), Color(0XFF94BBE9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
        isStatic?  SizedBox(height: 24):SizedBox(),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blueAccent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                  spreadRadius: 8.0,
                  color: Colors.black12,
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 4.0,
                    color: Colors.grey.shade200,
                  )
                ],
                image: staff.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(
                          staff.imageUrl!,
                        ),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: AssetImage(profile),
                        fit: BoxFit.cover,
                      ),
              ),
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SelectableText(
              staff.fullName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SelectableText(
              key: ValueKey("position"),
              staff.post,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SelectableText(
              staff.contact ?? 'Contact Not Available',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          isStatic?  SizedBox(height: 24):SizedBox(),

        ],
      ),
    );
  }
}

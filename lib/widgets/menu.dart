import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trishaheed/model/menu_content.dart';
import 'package:trishaheed/model/menu_list.dart';
import 'package:trishaheed/utilities/textstyles.dart';

// ignore: must_be_immutable
class Menu extends StatelessWidget {
  late MenuContent menuContent;
  late int index;
  Menu({menuContent, index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {},
      onHighlightChanged: ((value) {
        menuContent.selected = !menuContent.selected;
        Provider.of<MenuList>(context, listen: false)
            .update(menuContent, index);

        // print("value changed to: $value");
      }),
      child: Row(
        children: [
          SizedBox(width: 20),
          Text(
            "${menuContent.name}",
            style: CustomTextStyle.menu(context)?.copyWith(
              color: menuContent.selected
                  ? Color.fromRGBO(255, 85, 0, 0.961)
                  : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

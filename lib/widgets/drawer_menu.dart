import 'package:flutter/material.dart';
import 'package:trishaheed/utilities/menu_map.dart';

import '../pages/headers.dart';
import '../utilities/menu_tag.dart';
import '../utilities/textstyles.dart';

class DrawerMenu extends StatelessWidget {
  final void Function() onHome;
  final void Function() onNewNotice;
  final void Function() onResultPublished;
  final void Function(int value) onMenuSelected;
  const DrawerMenu({super.key,required this.onHome,required this.onNewNotice, required this.onResultPublished,required this.onMenuSelected});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
return  SingleChildScrollView(
  child: Container(
    color: Colors.black,
    height: size.height,
    width: size.width,
    padding: const EdgeInsets.all(4.0),
    child: Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeaderForMobile(
          onHome: onHome,
          onResultsPublished: onResultPublished,
          onNewNotice: onResultPublished,
        ),
        ...List<Widget>.generate(
          MenuTag.values.length - 3,
              (int index) {
            return Wrap(
              crossAxisAlignment:
              WrapCrossAlignment.start,
              children: [
                GestureDetector(
                  onTap: ()=> onMenuSelected(index),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 4.0),
                    height: 24,
                    child: Text(
                      MenuIndex.names.values
                          .elementAt(index),
                      style: CustomTextStyle.menu(
                          context)
                          ?.copyWith(),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.blueGrey.shade400,
                  thickness: 2,
                ),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'Copyright © 2022 | tri-shaheed',
            style: TextStyle(
              color: Colors.blueGrey.shade300,
              fontSize: 14,
            ),
          ),
        )
      ],
    ),
  ),
);
  }
}

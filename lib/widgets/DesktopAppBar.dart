import 'package:flutter/material.dart';

import '../pages/headers.dart';
import '../utilities/menu_map.dart';
import '../utilities/textstyles.dart';

class DesktopAppBar extends StatelessWidget {
  final void Function() onHome;
  final void Function() onNewNotice;
  final void Function() onResultPublished;
  final void Function(int value) onMenuSelected;

  const DesktopAppBar({super.key,required this.onHome,required this.onNewNotice, required this.onResultPublished,required this.onMenuSelected});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 1,
      flexibleSpace: FixHeader(
        onHome: onHome,
        onNewNotice: onNewNotice,
        onResultsPublished: onResultPublished,
      ),
      automaticallyImplyLeading: false,
      primary: false,
      bottom: TabBar(
        splashBorderRadius:
        BorderRadius.circular(4),
        indicatorSize: TabBarIndicatorSize.label,
        automaticIndicatorColorAdjustment: false,
        unselectedLabelColor: Colors.grey,
        labelPadding:
        EdgeInsets.symmetric(vertical: 8),
        indicator: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 8,
            color: Colors.blue,
          ),
        ),
        onTap: onMenuSelected,
        tabs: List.generate(
          MenuIndex.map.length - 3,
              (index) {
            return Align(
              alignment: Alignment.topCenter,
              child: Text(
                MenuIndex.names.values
                    .elementAt(index),
                style:
                CustomTextStyle.menu(context),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PopUpNotice extends StatelessWidget {
  final void Function() onViewNotice;
  final bool noticeExists;
  final String notice;
  const PopUpNotice({super.key, required this.onViewNotice,required this.noticeExists,required this.notice,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InteractiveViewer(
      scaleEnabled: true,
      constrained: false,
      alignment: Alignment.center,
      child: AnimatedContainer(
        height: size.height * 0.95,
        width: size.width,
        color: noticeExists
            ? Colors.white
            : Colors.orange,
        padding:
        EdgeInsets.symmetric(horizontal: 8.0),
        duration: Duration(milliseconds: 500),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                Text("New Notice From School"),
                MaterialButton(
                  onPressed: onViewNotice,
                  child: Icon(
                    Icons.cancel_sharp,
                    size: 36,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Image.asset(
              notice,
              fit: BoxFit.cover,
              height: size.height * 0.85,
              // width: size.width * 0.8,
            )
          ],
        ),
      ),
    );
  }
}

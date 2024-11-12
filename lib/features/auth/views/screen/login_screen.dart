import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("This is a login screen"),
            SizedBox(height: 24.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.sp),
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text("Login as Student"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

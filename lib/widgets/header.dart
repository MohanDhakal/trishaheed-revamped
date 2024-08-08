import 'package:flutter/material.dart';
import 'package:trishaheed/utilities/globals.dart';
import 'package:trishaheed/utilities/images.dart';
import '../pages/myapp_router_delegate.dart';
import '../utilities/menu_tag.dart';
import '../utilities/textstyles.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    logo,
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: SelectableText.rich(
                    TextSpan(
                      text: "श्री त्रि-शहिद",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                      children: [
                        TextSpan(
                          text: "\nनमुना मा.वि",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 80),
                Row(
                  children: [
                    Image.asset(
                      paperPlane,
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Email: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      Globals.schoolEmail,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 170),
                    Image.asset(
                      telephone,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Call: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      Globals.informationOfficerContact,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(

                          )
                        ),
                        alignment: Alignment.center,
                        child: Text("नयाँ सूचना"),
                        width: 100,
                        height: 50,
                      ),
                    ),
                    SizedBox(width: 150)
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.black87,
            height: 56,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                MenuTag.values.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      final delegate = MyAppRouterDelegate();
                      delegate.atMenu = MenuTag.values[index];
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        MenuTag.values[index].name,
                        style: CustomTextStyle.menu(context)?.copyWith(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

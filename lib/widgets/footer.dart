import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/utilities/globals.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  final Color? color;
  const FooterWidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;

    return Container(
      color: color,
      padding: EdgeInsets.only(top: 20),
      child: ResponsiveRowColumn(
        layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        columnMainAxisAlignment: MainAxisAlignment.start,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.spaceAround,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        columnPadding: EdgeInsets.only(left: 16.0),
        children: [
          ResponsiveRowColumnItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                      ? size.width * 0.8
                      : size.width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              Globals.schoolCoordinates,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          Text(
                            Globals.informationOfficerContact,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 4),
                          Text(
                            Globals.schoolEmail,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                    ? SizedBox(height: 12)
                    : SizedBox(),
                Text(
                  "Important Links",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.black,
                    ),
                    MaterialButton(
                      onPressed: () {
                        // _launchURL(Globals.aandhikholaRM);
                      },
                      child: Text(
                        "Aandhikhola Rural Municipality",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.black,
                    ),
                    MaterialButton(
                      onPressed: () {
                        // _launchURL(Globals.neb);
                      },
                      child: Text(
                        "Nepal Education Board ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.black,
                    ),
                    MaterialButton(
                      onPressed: () {
                        // _launchURL(Globals.moecdc);
                      },
                      child: Text(
                        "Curriculum Developement Center",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(child: SizedBox(height: 24)),

        ],
      ),
    );
  }

  // void _launchURL(String url) async {
  //   final Uri _url = Uri.parse(url);
  //
  //   if (await canLaunchUrl(_url)) {
  //     await launchUrl(_url);
  //   } else {
  //     print('Could not launch $url');
  //   }
  // }
}

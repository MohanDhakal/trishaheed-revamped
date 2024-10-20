import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/staff.dart';
import 'package:trishaheed/repository/staff_repo.dart';
import 'package:trishaheed/utilities/images.dart';
import '../utilities/selectables.dart';

// ignore: must_be_immutable
class StaffDetail extends StatefulWidget {
  Staff? staff;
  final int? id;
  void Function() onBackPressed;
  StaffDetail({
    Key? key,
    required this.staff,
    required this.id,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  State<StaffDetail> createState() => _StaffDetailState();
}

class _StaffDetailState extends State<StaffDetail> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _controller = ScrollController();
  String staffRank = "";
  Staff? staff;
  @override
  void initState() {
    staff = widget.staff;
    if (staff == null && widget.id != null) {
      StaffRepo().getStaffWithId(widget.id!).then((stf) {
        staff = stf;
        parseRank();
      });
    }
    if (staff != null) parseRank();
    super.initState();
  }

  void parseRank() {
    setState(() {
      staffRank = rank.entries
          .where(
            (entry) => entry.value == double.parse(staff!.rank),
          )
          .first
          .key;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      autofocus: true,
      child: Scaffold(
        
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 12),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: widget.onBackPressed,
                      iconSize: 24,
                    ),
                    SizedBox(width: 12),
                    Text(
                      " ${staff?.fullName}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ResponsiveRowColumnItem(
                  child: ResponsiveRowColumn(
                    layout: responsiveWrapper.isSmallerThan(TABLET)
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                    rowCrossAxisAlignment: CrossAxisAlignment.center,
                    columnCrossAxisAlignment: CrossAxisAlignment.center,
                    columnMainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      staff == null
                          ? ResponsiveRowColumnItem(child: SizedBox())
                          : ResponsiveRowColumnItem(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                                      image: staff!.imageUrl != null
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                staff!.imageUrl!,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: AssetImage(profile),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    width: 300,
                                    height: 360,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 16.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: staff?.fullName ?? "N/A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      responsiveWrapper.isSmallerThan(TABLET)
                          ? ResponsiveRowColumnItem(child: SizedBox(height: 24))
                          : ResponsiveRowColumnItem(child: SizedBox(width: 48)),
                      ResponsiveRowColumnItem(
                        child: SizedBox(
                          width: responsiveWrapper.isSmallerThan(TABLET)
                              ? size.width
                              : size.width * 0.35,
                          child: Card(
                            elevation: 8,
                            color: Colors.grey.shade100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 24,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Detailed Information" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  Divider(thickness: 4),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Level :" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.teacherLevel ?? "N/A",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "SUBJECT :" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.majorSubject ?? "N/A",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "POSITION :" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.post ?? "N/A",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Rank :" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staffRank,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Major Subject: " + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.majorSubject,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Address: " + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.address,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Date Of Birth: " + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.dob,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Jonined At: " + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.joinedAt,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Job Type: " + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.jobType,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Phone Number :" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.contact ?? "98*******",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Email Address :" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: staff?.email ?? "abc@gmail.com",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    var offset = _controller.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 200,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 200,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset + 200,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset + 200,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    }
  }
}

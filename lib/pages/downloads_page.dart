import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/download_menu.dart';
import 'package:trishaheed/utilities/download_enums.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  Downloads selectedPage = Downloads.others;

  List<DownloadMenu> downloadMenuList = <DownloadMenu>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return ResponsiveRowColumn(
      rowMainAxisAlignment: MainAxisAlignment.start,
      layout: responsiveWrapper.isSmallerThan(TABLET)
          ? ResponsiveRowColumnType.COLUMN
          : ResponsiveRowColumnType.ROW,
      children: [
        ResponsiveRowColumnItem(child: SizedBox(width: 24)),
        ResponsiveRowColumnItem(
          child: SizedBox(
              width: responsiveWrapper.isSmallerThan(TABLET)
                  ? screenWidth
                  : screenWidth * 0.20,
              child: ResponsiveRowColumn(
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                rowMainAxisAlignment: MainAxisAlignment.start,
                columnMainAxisAlignment: MainAxisAlignment.start,
                layout: responsiveWrapper.isSmallerThan(TABLET)
                    ? ResponsiveRowColumnType.ROW
                    : ResponsiveRowColumnType.COLUMN,
                children: [
                  ResponsiveRowColumnItem(
                      child: SizedBox(
                    height: responsiveWrapper.isSmallerThan(TABLET) ? 0 : 16,
                    width: responsiveWrapper.isSmallerThan(TABLET) ? 8 : 0,
                  )),
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Downloads",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveValue(
                            context,
                            defaultValue: 16.0,
                            valueWhen: const [
                              Condition.smallerThan(
                                name: TABLET,
                                value: 16.0,
                              ),
                              Condition.largerThan(
                                name: TABLET,
                                value: 24.0,
                              )
                            ],
                          ).value,
                        ),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: SizedBox(
                    height: responsiveWrapper.isSmallerThan(TABLET) ? 0 : 8,
                    width: responsiveWrapper.isSmallerThan(TABLET) ? 8 : 0,
                  )),
                  ResponsiveRowColumnItem(
                    child: responsiveWrapper.isSmallerThan(TABLET)
                        ? SizedBox()
                        : Divider(
                            thickness: 4,
                            color: Colors.black,
                          ),
                  ),
                  ResponsiveRowColumnItem(
                      child: SizedBox(
                    height: responsiveWrapper.isSmallerThan(TABLET) ? 0 : 16,
                    width: responsiveWrapper.isSmallerThan(TABLET) ? 16 : 0,
                  )),
                  ResponsiveRowColumnItem(
                    child: MaterialButton(
                      onPressed: () {
                        setState(() => selectedPage = Downloads.results);
                      },
                      child: Text(
                        "Results",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: SizedBox(
                    height: responsiveWrapper.isSmallerThan(TABLET) ? 0 : 16,
                    width: responsiveWrapper.isSmallerThan(TABLET) ? 16 : 0,
                  )),
                  ResponsiveRowColumnItem(
                    child: MaterialButton(
                      onPressed: () {
                        setState(() => selectedPage = Downloads.routine);
                      },
                      child: Text(
                        "Routine",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: SizedBox(
                    height: responsiveWrapper.isSmallerThan(TABLET) ? 0 : 8,
                    width: responsiveWrapper.isSmallerThan(TABLET) ? 8 : 0,
                  )),
                  ResponsiveRowColumnItem(
                    child: MaterialButton(
                      onPressed: () {
                        setState(() => selectedPage = Downloads.others);
                      },
                      child: Text(
                        "Others",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        selectedPage == Downloads.results
            ? ResponsiveRowColumnItem(
                child: Container(
                  width: screenWidth * 0.75,
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 72),
                      const PlacholderDownloads(),
                      Divider(
                        thickness: 2,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(height: 8),
                      DownloadFile(
                        name: "2079 Result Grade 10",
                        action: '',
                        sn: 1,
                      ),
                      SizedBox(height: 4),
                      DownloadFile(
                        name: "2080 Result Grade 10",
                        action: '',
                        sn: 2,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey.shade300,
                      ),
                      PaginatorWidget()
                    ],
                  ),
                ),
              )
            : selectedPage == Downloads.routine
                ? ResponsiveRowColumnItem(
                    child: Container(
                      width: screenWidth * 0.75,
                      margin: EdgeInsets.zero,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 72),
                          const PlacholderDownloads(),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 8),
                          DownloadFile(
                            name: "2079 Result Grade 10",
                            action: '',
                            sn: 1,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          DownloadFile(
                            name: "2079 Result Grade 10",
                            action: '',
                            sn: 2,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.shade300,
                          ),
                          PaginatorWidget()
                        ],
                      ),
                    ),
                  )
                : selectedPage == Downloads.others
                    ? ResponsiveRowColumnItem(
                        child: Container(
                          width: screenWidth * 0.75,
                          margin: EdgeInsets.zero,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 72),
                              const PlacholderDownloads(),
                              Divider(
                                thickness: 2,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 8),
                              DownloadFile(
                                name: "2079 Result Grade 10",
                                action: '',
                                sn: 1,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              DownloadFile(
                                name: "2079 Result Grade 10",
                                action: '',
                                sn: 2,
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey.shade300,
                              ),
                              PaginatorWidget()
                            ],
                          ),
                        ),
                      )
                    : ResponsiveRowColumnItem(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("Unexpected Error Occured"),
                          ),
                        ),
                      ),
      ],
    );
  }
}

class PaginatorWidget extends StatelessWidget {
  const PaginatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: () {},
          child: Container(
            width: 100,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Text("Previous"),
          ),
        ),
        SizedBox(width: 12),
        Container(
            width: 100,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Text(
              "1 of 12",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            )),
        SizedBox(width: 12),
        MaterialButton(
          onPressed: () {},
          child: Container(
            width: 100,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Text("Next"),
          ),
        ),
      ],
    );
  }
}

class PlacholderDownloads extends StatelessWidget {
  const PlacholderDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "S.N",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveValue(
                context,
                defaultValue: 16.0,
                valueWhen: const [
                  Condition.smallerThan(
                    name: TABLET,
                    value: 12.0,
                  ),
                  Condition.largerThan(
                    name: TABLET,
                    value: 24.0,
                  )
                ],
              ).value,
            ),
          ),
          Text(
            "File Name",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveValue(
                context,
                defaultValue: 16.0,
                valueWhen: const [
                  Condition.smallerThan(
                    name: TABLET,
                    value: 12.0,
                  ),
                  Condition.largerThan(
                    name: TABLET,
                    value: 24.0,
                  )
                ],
              ).value,
            ),
          ),
          Text(
            "Action",
            style: TextStyle(
              color: Colors.black,
              fontSize: ResponsiveValue(
                context,
                defaultValue: 16.0,
                valueWhen: const [
                  Condition.smallerThan(
                    name: TABLET,
                    value: 12.0,
                  ),
                  Condition.largerThan(
                    name: TABLET,
                    value: 24.0,
                  )
                ],
              ).value,
            ),
          )
        ],
      ),
    );
  }
}

class DownloadFile extends StatelessWidget {
  final int sn;
  final String name;
  final String action;
  const DownloadFile({
    Key? key,
    required this.sn,
    required this.action,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sn.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: ResponsiveValue(
                context,
                defaultValue: 16.0,
                valueWhen: const [
                  Condition.smallerThan(
                    name: TABLET,
                    value: 12.0,
                  ),
                  Condition.largerThan(
                    name: TABLET,
                    value: 16.0,
                  )
                ],
              ).value,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              // color: Colors.blue,
              fontSize: ResponsiveValue(
                context,
                defaultValue: 16.0,
                valueWhen: const [
                  Condition.smallerThan(
                    name: TABLET,
                    value: 12.0,
                  ),
                  Condition.largerThan(
                    name: TABLET,
                    value: 16.0,
                  )
                ],
              ).value,
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              "Download",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                fontSize: ResponsiveValue(
                  context,
                  defaultValue: 16.0,
                  valueWhen: const [
                    Condition.smallerThan(
                      name: TABLET,
                      value: 12.0,
                    ),
                    Condition.largerThan(
                      name: TABLET,
                      value: 16.0,
                    )
                  ],
                ).value,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DownloadOption extends StatelessWidget {
  final DownloadMenu option;
  const DownloadOption({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.blue.shade300,
        boxShadow: option.clicked
            ? [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2, 2),
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                )
              ]
            : null,
      ),
      child: Text(
        option.downloads.name,
        style: TextStyle(
          color: Colors.black,
          fontSize: ResponsiveValue(
            context,
            defaultValue: 24.0,
            valueWhen: const [
              Condition.smallerThan(
                name: TABLET,
                value: 12.0,
              ),
              Condition.largerThan(
                name: TABLET,
                value: 16.0,
              )
            ],
          ).value,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:trishaheed/model/download_menu.dart';
import 'package:trishaheed/utilities/download_enums.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  Downloads? selectedPage;

  Future<void> getData() async {
    for (var i = 0; i < 3; i++) {
      final menu;
      if (i == 1) {
        menu = DownloadMenu(Downloads.routine, "https://google.com");
      } else {
        menu = DownloadMenu(Downloads.results, "https://google.com");
      }
      downloadMenuList.add(menu);
    }
  }

  List<DownloadMenu> downloadMenuList = <DownloadMenu>[];

  @override
  void initState() {
    getData().then((value) {
      setState(
        () {},
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return Row(
      children: [
        downloadMenuList.isEmpty
            ? Center(child: Text("Options Loading..."))
            : Container(
                color: Colors.black12,
                width: screenWidth * 0.25,
                child: responsiveWrapper.isDesktop
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 2,
                        ),
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        itemCount: downloadMenuList.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: (() {
                              downloadMenuList.forEach((element) {
                                if (element.clicked) {
                                  element.clicked = false;
                                  selectedPage = null;
                                }
                              });
                              downloadMenuList[index].clicked = true;
                              selectedPage = downloadMenuList[index].downloads;
                              setState(() {});
                            }),
                            child: DownloadOption(
                              option: downloadMenuList[index],
                            ),
                          );
                        }),
                      )
                    : ListView.builder(
                        itemCount: downloadMenuList.length,
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: (() {
                              downloadMenuList.forEach((element) {
                                if (element.clicked) {
                                  element.clicked = true;
                                }
                              });
                              downloadMenuList[index].clicked = true;
                              selectedPage = downloadMenuList[index].downloads;
                              setState(() {});
                            }),
                            child: DownloadOption(
                              option: downloadMenuList[index],
                            ),
                          );
                        }),
                      ),
              ),
        selectedPage == Downloads.results
            ? Container(
                width: screenWidth * 0.75,
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DownloadFile(
                      name: "Result Link of the file to download",
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    DownloadFile(
                      name: "Result Link of the file to download",
                    ),
                  ],
                ),
              )
            : selectedPage == Downloads.routine
                ? Container(
                    width: screenWidth * 0.75,
                    margin: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DownloadFile(
                          name: "Routine Link of the file to download",
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        DownloadFile(
                          name: "Routine Link of the file to download",
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                          "Select one of the download option from the left panel"),
                    ),
                  ),
      ],
    );
  }
}

class DownloadFile extends StatelessWidget {
  final String name;
  const DownloadFile({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
      height: 50,
      width: screenWidth * 0.1,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 5),
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
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.deepPurpleAccent,
          boxShadow: option.clicked
              ? [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2, 2),
                      blurRadius: 0.5,
                      spreadRadius: 0.5)
                ]
              : null),
    );
  }
}

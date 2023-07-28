import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/download_menu.dart';
import 'package:trishaheed/model/states/dowloads_state.dart';
import 'package:trishaheed/utilities/download_enums.dart';

import '../utilities/file_path_remover.dart';
import '../utilities/loading_dialog.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List<DownloadMenu> downloadMenuList = <DownloadMenu>[];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      Provider.of<DownloadState>(context, listen: false).getFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return Consumer<DownloadState>(builder: (context, model, child) {
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
                    ),
                  ),
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
                    ),
                  ),
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
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: MaterialButton(
                      onPressed: () async {
                        model.currentPage = 1;
                        model.totalPage = 1;
                        showLoadingDialog(context);
                        model.selectedFolder = Downloads.results;
                        model.refreshFiles().then((value) {
                          Navigator.pop(context);
                        });
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
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: MaterialButton(
                      onPressed: () async {
                        model.currentPage = 1;
                        model.totalPage = 1;

                        showLoadingDialog(context);
                        model.selectedFolder = Downloads.routine;
                        model.refreshFiles().then((value) {
                          Navigator.pop(context);
                        });
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
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: MaterialButton(
                      onPressed: () {
                        model.currentPage = 1;
                        model.totalPage = 1;
                        showLoadingDialog(context);
                        model.selectedFolder = Downloads.others;
                        model.refreshFiles().then((value) {
                          Navigator.pop(context);
                        });
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
              ),
            ),
          ),
          model.selectedFolder == Downloads.results
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
                        ...List.generate(
                          model.selectedDownloads.length,
                          (index) {
                            int sn = index + 1;
                            return DownloadFile(
                              sn: sn,
                              action: 'Downloads',
                              name: model.selectedDownloads.elementAt(index),
                            );
                          },
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
              : model.selectedFolder == Downloads.routine
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
                            ...List.generate(
                              model.selectedDownloads.length,
                              (index) {
                                int sn = index + 1;
                                return DownloadFile(
                                  sn: sn,
                                  action: 'Downloads',
                                  name:
                                      model.selectedDownloads.elementAt(index),
                                );
                              },
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
                  : model.selectedFolder == Downloads.others
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
                                ...List.generate(
                                  model.selectedDownloads.length,
                                  (index) {
                                    int sn = index + 1;
                                    return DownloadFile(
                                      sn: sn,
                                      action: 'Downloads',
                                      name: model.selectedDownloads
                                          .elementAt(index),
                                    );
                                  },
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
    });
  }
}

class PaginatorWidget extends StatelessWidget {
  const PaginatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadState>(builder: (context, model, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MaterialButton(
            onPressed: () {
              if (model.currentPage > 1) {
                model.currentPage--;
                showLoadingDialog(context);
                model.refreshFiles().then((value) {
                  Navigator.pop(context);
                });
              }
            },
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
                "${model.currentPage} of ${model.totalPage}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )),
          SizedBox(width: 12),
          MaterialButton(
            onPressed: () {
              if (model.currentPage < model.totalPage) {
                model.currentPage++;
                showLoadingDialog(context);
                model.refreshFiles().then((value) {
                  Navigator.pop(context);
                });
              }
            },
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
    });
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
            removeDir(name),
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
            onPressed: () async {
              final model = Provider.of<DownloadState>(context, listen: false);
              await model.downloadFile(name);
            },
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
    // final double screenWidth = MediaQuery.of(context).size.width;

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

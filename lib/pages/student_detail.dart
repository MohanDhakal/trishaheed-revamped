import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/data_source.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key}) : super(key: key);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  late StudentData _studentData;
  String dropdownvalue = 'one';
  static const TextStyle headerStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple,
  );

  var items = ["one", "two", "three"];

  @override
  void initState() {
    _studentData = StudentData.empty();

    _studentData.addStudent().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: PaginatedDataTable2(
        columnSpacing: 12,

        horizontalMargin: 12,
        rowsPerPage: _studentData.rowCount,
        headingRowHeight:
            ResponsiveWrapper.of(context).isSmallerThan(DESKTOP) ? 150 : 56,
        header: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            minWidth: 100,
            height:
                ResponsiveWrapper.of(context).isSmallerThan(DESKTOP) ? 150 : 56,
            child: Material(
              color: Colors.black12,
              child: ResponsiveRowColumn(
                layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                columnMainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "   [TRI-SHAHEED MODEL SECONDARY SCHOOL] Student Information for Grade      ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        // alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        // margin: EdgeInsets.only(top: 10),
                        color: Colors.purpleAccent,
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvalue,

                          icon: const Icon(Icons.keyboard_arrow_down),
                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
        columns: [
          DataColumn2(
            label: Text(
              'Full Name',
              style: headerStyle.copyWith(
                fontSize: ResponsiveValue(
                  context,
                  defaultValue: 20.0,
                  valueWhen: const [
                    Condition.smallerThan(
                      name: TABLET,
                      value: 14.0,
                    ),
                    Condition.largerThan(
                      name: TABLET,
                      value: 20.0,
                    )
                  ],
                ).value,
              ),
            ),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text(
              'Date of Birth',
              style: headerStyle.copyWith(
                fontSize: ResponsiveValue(
                  context,
                  defaultValue: 20.0,
                  valueWhen: const [
                    Condition.smallerThan(
                      name: TABLET,
                      value: 14.0,
                    ),
                    Condition.largerThan(
                      name: TABLET,
                      value: 20.0,
                    )
                  ],
                ).value,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Joined Year',
              style: headerStyle.copyWith(
                fontSize: ResponsiveValue(
                  context,
                  defaultValue: 20.0,
                  valueWhen: const [
                    Condition.smallerThan(
                      name: TABLET,
                      value: 14.0,
                    ),
                    Condition.largerThan(
                      name: TABLET,
                      value: 20.0,
                    )
                  ],
                ).value,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Mother/Father Name',
              style: headerStyle.copyWith(
                fontSize: ResponsiveValue(
                  context,
                  defaultValue: 20.0,
                  valueWhen: const [
                    Condition.smallerThan(
                      name: TABLET,
                      value: 12.0,
                    ),
                    Condition.largerThan(
                      name: TABLET,
                      value: 20.0,
                    )
                  ],
                ).value,
              ),
            ),
          ),
        ],
        empty: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey[200],
            child: const Text('No data'),
          ),
        ),
        source: _studentData,
      ),
    );
  }
}

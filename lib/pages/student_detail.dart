import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
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
        header: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            minWidth: 100,
            child: Material(
                color: Colors.black12,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "   [TRI-SHAHEED MODEL SECONDARY SCHOOL] Student Information for Grade      ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.only(top: 10),
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
                    Container(
                      color: Colors.blue,
                    )
                  ],
                )),
          ),
        ),
        // headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
        columns: [
          DataColumn2(
            label: Text(
              'Full Name',
              style: headerStyle,
            ),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text(
              'Date of Birth',
              style: headerStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'Joined Year',
              style: headerStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'Mother/Father Name',
              style: headerStyle,
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

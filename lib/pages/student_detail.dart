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
        minWidth: 200,
        header: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            minWidth: 200,
            child: Material(
              color: Colors.black12,
              child: DropdownButton(
                // Initial Value
                value: dropdownvalue,
                isExpanded: true,
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
        // headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
        columns: [
          DataColumn2(
            label: Text('Full Name'),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text('Date of Birth'),
          ),
          DataColumn(
            label: Text('Joined Year'),
          ),
          DataColumn(
            label: Text('Mother/Father Name'),
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

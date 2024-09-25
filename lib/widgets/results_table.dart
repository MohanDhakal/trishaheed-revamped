import 'package:flutter/material.dart';
import '../model/Exam.dart';
import '../model/Result.dart';
import '../model/student.dart';

class ResultsTable extends StatefulWidget {
  final List<Result> results;
  final Exam exam;
  final Student student;
  const ResultsTable({
    super.key,
    required this.results,
    required this.exam,
    required this.student,
  });

  @override
  State<ResultsTable> createState() => _ResultsTableState();
}

class _ResultsTableState extends State<ResultsTable> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        primary: true,
        child: DataTable(
          dataRowMinHeight: 16,
          dataRowMaxHeight: 28,
          headingRowColor: MaterialStateProperty.all(Colors.green[300]),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'SUB.CODE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'SUBJECTS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'CR. HR.',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            DataColumn(
              label: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'GRADE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            DataColumn(
              label: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'GP',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            DataColumn(
              label: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'F.G',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            DataColumn(
              label: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'REMARKS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          rows: widget.results
              .map(
                (result) => DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(
                        '${result.subjectCode}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${result.subjectName}(${result.marksType})',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${result.credit ?? 0.0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(Text(
                      result.grade ?? 'NG',
                      style: TextStyle(fontSize: 16),
                    )),
                    DataCell(
                      Text(
                        '${result.gradePoint ?? 0.0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(
                        result.grade ?? 'NG',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(' '),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

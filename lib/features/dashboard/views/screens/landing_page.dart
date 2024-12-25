import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome, Mohan"),
            Text("See results summary for latest exam, select grade below"),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(24),
            //     // Rounding the corners
            //     border: Border.all(color: Colors.grey, width: 1),
            //   ),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton<Grade>(
            //       hint: Text("Select Grade"),
            //       value: state.grade,
            //       icon: Icon(Icons.arrow_drop_down),
            //       iconSize: 24,
            //       isExpanded: true,
            //       dropdownColor: Colors.white,
            //       style: TextStyle(color: Colors.black, fontSize: 16),
            //       borderRadius: BorderRadius.circular(25),
            //       onChanged: loginCubit.setSelectedGrade,
            //       items: loginCubit.grades.map<DropdownMenuItem<Grade>>(
            //         (Grade value) {
            //           return DropdownMenuItem<Grade>(
            //             value: value,
            //             child: Text(value.name),
            //           );
            //         },
            //       ).toList(),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

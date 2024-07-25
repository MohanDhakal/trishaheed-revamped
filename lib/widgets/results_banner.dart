
import 'package:flutter/material.dart';

class ResultsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Steps to Get the Results',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple
              ),
            ),
            SizedBox(height: 10.0),
            StepItem(
              stepNumber: '1',
              description: 'Academic Year मा शैक्षिक सत्र छान्नुहोस ।',
            ),
            StepItem(
              stepNumber: '2',
              description: 'Exam Menu मा परिक्षाको प्रकार छान्नुहोस । ',
            ),
            StepItem(
              stepNumber: '3',
              description: 'Grade Menu मा विद्यार्थीको कक्षा छान्नुहोस। ',
            ),
            StepItem(
              stepNumber: '4',
              description: 'अन्तिममा विद्यार्थीको रोल नम्बर छान्नुहोस ',
            ),
            StepItem(
              stepNumber: '5',
              description: 'अब Show Result Section मा प्रेस गर्नुहोस, तपाँईको रिजल्ट केही समयमै सक्रिनमा देखिनेछ। ',
            ),
          ],
        ),
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final String stepNumber;
  final String description;

  StepItem({required this.stepNumber, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 15.0,
            child: Text(stepNumber),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              description,
              style: TextStyle(fontSize: 16.0,

              ),
            ),
          ),
        ],
      ),
    );
  }
}
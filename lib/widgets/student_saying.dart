import 'package:flutter/material.dart';
import '../utilities/images.dart';

class StudentSaying extends StatelessWidget {
  const StudentSaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              profile,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.2,
                child: Text(
                  """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.8,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Mohan Kumar Dhakal",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Former Student",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Color.fromARGB(255, 255, 102, 0),
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

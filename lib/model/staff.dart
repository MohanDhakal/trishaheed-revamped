import 'package:flutter/material.dart';
import 'package:trishaheed/utilities/button_position.dart';

class Staff {
  int id;
  //this means taha 0 means lower, increases with level(taha anusar)
  //just to arrange according to level
  int points;
  String fullName;
  String teacherLevel;
  String majorSubject;
  String? email;
  String? contact;
  //state hovered or clicked or sth else
  Position position;
  Staff(
    this.id,
    this.points,
    this.fullName,
    this.teacherLevel,
    this.majorSubject,
    this.position,
  );
}

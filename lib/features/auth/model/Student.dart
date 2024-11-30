// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Student extends Equatable{
  final int? id;
  final int roll_number;
  final String name;
  Student({
    this.id,
    required this.roll_number,
    required this.name,
  });

  Student copyWith({
    int? id,
    int? roll_number,
    String? name,
  }) {
    return Student(
      id: id ?? this.id,
      roll_number: roll_number ?? this.roll_number,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'roll_number': roll_number,
      'name': name,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] != null ? map['id'] as int : null,
      roll_number: map['roll_number'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Student(id: $id, roll_number: $roll_number, name: $name)';

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.roll_number == roll_number &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ roll_number.hashCode ^ name.hashCode;
  
  @override
  List<Object?> get props => [roll_number,name];
}

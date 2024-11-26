// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Student extends Equatable{
  final int? id;
  final int rollNumber;
  final String name;
  Student({
    this.id,
    required this.rollNumber,
    required this.name,
  });

  Student copyWith({
    int? id,
    int? rollNumber,
    String? name,
  }) {
    return Student(
      id: id ?? this.id,
      rollNumber: rollNumber ?? this.rollNumber,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rollNumber': rollNumber,
      'name': name,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] != null ? map['id'] as int : null,
      rollNumber: map['rollNumber'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Student(id: $id, rollNumber: $rollNumber, name: $name)';

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.rollNumber == rollNumber &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ rollNumber.hashCode ^ name.hashCode;
  
  @override
  List<Object?> get props => [rollNumber,name];
}

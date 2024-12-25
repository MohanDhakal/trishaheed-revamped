// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
  final int? id;
  final String name;
  final int age;
  Teacher({
    this.id,
    required this.name,
    required this.age,
  });

  Teacher copyWith({
    int? id,
    String? name,
    int? age,
  }) {
    return Teacher(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Teacher(id: $id, name: $name, age: $age)';

  @override
  bool operator ==(covariant Teacher other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.age == age;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ age.hashCode;

  @override
  List<Object?> get props => [id, name, age];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Grade extends Equatable {
  final int? id;
  final int num;
  final String name;
  Grade({
    this.id,
    required this.num,
    required this.name,
  });

  Grade copyWith({
    int? id,
    int? num,
    String? name,
  }) {
    return Grade(
      id: id ?? this.id,
      num: num ?? this.num,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'num': num,
      'name': name,
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id'] != null ? map['id'] as int : null,
      num: map['num'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Grade.fromJson(String source) =>
      Grade.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Grade(id: $id, num: $num, name: $name)';

  @override
  bool operator ==(covariant Grade other) {
    if (identical(this, other)) return true;

    return other.id == id && other.num == num && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ num.hashCode ^ name.hashCode;

  @override
  List<Object?> get props => [id, name, num];
}

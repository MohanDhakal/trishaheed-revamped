// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class School {
  final String name;
  final String code;
  School({
    required this.name,
    required this.code,
  });

  School copyWith({
    String? name,
    String? code,
  }) {
    return School(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
    };
  }

  factory School.fromMap(Map<String, dynamic> map) {
    return School(
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory School.fromJson(String source) =>
      School.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'School(name: $name, code: $code)';

  @override
  bool operator ==(covariant School other) {
    if (identical(this, other)) return true;
    return other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}

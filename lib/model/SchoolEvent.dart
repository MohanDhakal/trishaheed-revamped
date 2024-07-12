// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class SchoolEvent {
  int? id;
  String eventName;
  String eventDescription;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  Uint8List? image;
  String? imageUri;
  SchoolEvent({
    this.id,
    required this.eventName,
    required this.eventDescription,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.image,
    this.imageUri,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': eventName,
      'description': eventDescription,
      'start_date': startDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'image': image,
    };
  }

  factory SchoolEvent.fromMap(Map<String, dynamic> map) {
    return SchoolEvent(
      id: map['id'] as int,
      eventName: map['name'] as String,
      eventDescription: map['description'] as String,
      startDate: map['start_date'] as String,
      endDate: map['end_date'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
      imageUri: map['event_banner'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SchoolEvent.fromJson(String source) =>
      SchoolEvent.fromMap(json.decode(source) as Map<String, dynamic>);
}

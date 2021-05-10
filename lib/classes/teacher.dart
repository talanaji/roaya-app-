import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Teacher {
  int tCode;
  String tRegDate;
  String tName;
  String tID;
  String tBirthday;
  String tGender;
  String tEmail;
  String tCoursesCodes;
  String tPhone1;
  String tTown;
  String tNotes;
  String tActive;
  Teacher(
      {
    this.tCode,
    this.tRegDate,
    this.tName,
    this.tID,
    this.tBirthday,
    this.tGender,
    this.tEmail,
    this.tCoursesCodes,
    this.tPhone1,
    this.tTown,
    this.tNotes,
    this.tActive,});

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}

@JsonSerializable()
class TeacherList {
  List<Teacher> teachers;

  TeacherList({this.teachers});
  factory TeacherList.fromJson(List<dynamic> json) {
    return TeacherList(
        teachers: json
            .map((e) => Teacher.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

Teacher _$TeacherFromJson(Map<String, dynamic> json) {
  return Teacher(
    
      tCode: int.parse(json['te_code']),
      tRegDate: json['te_reg_date'],
      tName: json['te_name'],
      tID: json['te_ID'],
      tBirthday: json['te_birthday'],
      tGender: json['te_gender'],
      tEmail: json['te_email'],
      tCoursesCodes: json['te_courses_codes'],
      tPhone1: json['te_phone1'],
      tTown: json['te_town'],
      tNotes: json['te_notes'],
      tActive: json['te_active']
  );
}

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      
      'te_code': instance.tCode,
      'te_reg_date': instance.tRegDate,
      'te_name': instance.tName,
      'te_ID': instance.tID,
      'te_birthday': instance.tBirthday,
      'te_gender': instance.tGender,
      'te_email': instance.tEmail,
      'te_courses_codes': instance.tCoursesCodes,
      'te_phone1': instance.tPhone1,
      'te_town': instance.tTown,
      'te_notes': instance.tNotes,
      'te_active': instance.tActive,
    }; 

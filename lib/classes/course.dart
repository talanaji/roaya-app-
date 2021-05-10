import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Course {
  int cCode;
  String cName;
  String cActive;
  Course({
    this.cCode,
    this.cName,
    this.cActive,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

@JsonSerializable()
class CourseList {
  List<Course> courses;

  CourseList({this.courses});
  factory CourseList.fromJson(List<dynamic> json) {
    return CourseList(
        courses: json
            .map((e) => Course.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
      cCode: int.parse(json['c_code']),
      cName: json['c_name'],
      cActive: json['c_active']);
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'c_code': instance.cCode,
      'c_name': instance.cName,
      'c_active': instance.cActive
    };

/*CourseList _$CourseListFromJson(Map<String, dynamic> json) {
  return CourseList(
      courses: (json['courses'] as List)
          ?.map((e) =>
              e == null ? null : Course.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CourseListToJson(CourseList instance) =>
    <String, dynamic>{'courses': instance.courses};
*/
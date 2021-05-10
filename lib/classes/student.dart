import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Student {
  int stdCode;
  int fkUserCode;
  String stdName;
  String stdPassword;
  String stdPassword2;
  String stdRegDate;
  String stdSchoolCode;
  String stdClass;
  String stdEmail;
  String stdTown;
  String stdSex;
  String stdBirthdate;
  String stdSubCode;
  String stdPrice;
  String stdPaymentMethodsCode;
  String stdStatusCode;
  String stdPaymentDate;
  String stdActive;
  String stdID;
  String stdPhone1;
  String stdPhone2;
  String stdSmsSub;
  String stdBalance;
  Student({
    this.stdCode,
    this.fkUserCode,
    this.stdName,
    this.stdPassword,
    this.stdPassword2,
    this.stdRegDate,
    this.stdSchoolCode,
    this.stdClass,
    this.stdEmail,
    this.stdTown,
    this.stdSex,
    this.stdBirthdate,
    this.stdSubCode,
    this.stdPrice,
    this.stdPaymentMethodsCode,
    this.stdStatusCode,
    this.stdPaymentDate,
    this.stdActive,
    this.stdID,
    this.stdPhone1,
    this.stdPhone2,
    this.stdSmsSub,
    this.stdBalance,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}

@JsonSerializable()
class StudentList {
  List<Student> students;

  StudentList({this.students});
  factory StudentList.fromJson(List<dynamic> json) {
    return StudentList(
        students: json
            .map((e) => Student.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
      stdCode: int.parse(json['st_code']),
      fkUserCode: int.parse(json['fk_user_code']),
      stdName: json['st_name'],
      stdPassword: json['st_password'],
      stdPassword2: json['st_password2'],
      stdRegDate: json['st_reg_date'],
      stdSchoolCode: json['st_school_code'],
      stdClass: json['st_class'],
      stdEmail: json['st_email'],
      stdTown: json['st_town'],
      stdSex: json['st_sex'],
      stdBirthdate: json['st_birthdate'],
      stdSubCode: json['st_sub_code'],
      stdPrice: json['st_price'],
      stdPaymentMethodsCode: json['st_paymentmethods_code'],
      stdStatusCode: json['st_status_code'],
      stdPaymentDate: json['st_payment_date'],
      stdActive: json['st_active'],
      stdID: json['st_ID'],
      stdPhone1: json['st_phone1'],
      stdPhone2: json['st_phone2'],
      stdSmsSub: json['st_SMS_sub'],
      stdBalance: json['st_balance']);
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'st_code': instance.stdCode,
      'fk_user_code': instance.fkUserCode,
      'st_name': instance.stdName,
      'st_password': instance.stdPassword,
      'st_password2': instance.stdPassword2,
      'st_reg_date': instance.stdRegDate,
      'st_school_code': instance.stdSchoolCode,
      'st_class': instance.stdClass,
      'st_email': instance.stdEmail,
      'st_town': instance.stdTown,
      'st_sex': instance.stdSex,
      'st_birthdate': instance.stdBirthdate,
      'st_sub_code': instance.stdSubCode,
      'st_price': instance.stdPrice,
      'st_paymentmethods_code': instance.stdPaymentMethodsCode,
      'st_status_code': instance.stdStatusCode,
      'st_payment_date': instance.stdPaymentDate,
      'st_active': instance.stdActive,
      'st_ID': instance.stdID,
      'st_phone1': instance.stdPhone1,
      'st_phone2': instance.stdPhone2,
      'st_SMS_sub': instance.stdSmsSub,
      'st_balance': instance.stdBalance
    };
 
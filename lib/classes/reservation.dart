 import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Reservation {
  int resCode;
  int resUserCode;
  String resToDate;
  int resTchrCode;
  int resStdCode;
  int resCrsCode;
  String resPaidPrice;
  String resTchrPercent;
  int resRoomCode;
  String resTimeStart;
  String resTimeEnd;
  String resTchrNote;
  String resAdminNote;
  String btnResEdit;
  String resIsConfirmed;
  String isSmsSent;
  String resIsPaid;
  String resTchrIsPaid;
  Reservation(
      {this.resCode,
      this.resUserCode,
      this.resToDate,
      this.resTchrCode,
      this.resStdCode,
      this.resCrsCode,
      this.resPaidPrice,
      this.resTchrPercent,
      this.resRoomCode,
      this.resTimeStart,
      this.resTimeEnd,
      this.resTchrNote,
      this.resAdminNote,
      this.btnResEdit,
      this.resIsConfirmed,
      this.isSmsSent,
      this.resIsPaid,
      this.resTchrIsPaid});

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}

@JsonSerializable()
class ReservationList {
  List<Reservation> reservations;

  ReservationList({this.reservations});
  factory ReservationList.fromJson(List<dynamic> json) {
    return ReservationList(
        reservations: json
            .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class TeacherReservationsMonthlyHours {
  String monthlyHours;
  TeacherReservationsMonthlyHours({this.monthlyHours});
  factory TeacherReservationsMonthlyHours.fromJson(Map<String, dynamic> json) =>
      _$TeacherReservationsMonthlyHoursFromJson(json);
  Map<String, dynamic> toJson() =>
      _$TeacherReservationsMonthlyHoursToJson(this);
}
class TeacherReservationsMonthlyConfirmedHours {
  String monthlyConfrimedHours;
  TeacherReservationsMonthlyConfirmedHours({this.monthlyConfrimedHours});
  factory TeacherReservationsMonthlyConfirmedHours.fromJson(Map<String, dynamic> json) =>
      _$TeacherReservationsMonthlyConfHoursFromJson(json);
  Map<String, dynamic> toJson() =>
      _$TeacherReservationsMonthlyConfHoursToJson(this);
}
class TeacherMonthSalary {
  String salary;
  TeacherMonthSalary({this.salary});
  factory TeacherMonthSalary.fromJson(Map<String, dynamic> json) =>
      _$TeacherMonthSalaryFromJson(json);
  Map<String, dynamic> toJson() =>
      _$TeacherMonthSalaryToJson(this);
}
TeacherMonthSalary _$TeacherMonthSalaryFromJson(
    Map<String, dynamic> json) {
  return TeacherMonthSalary(
    salary: json['ct'],
    );
}

Map<String, dynamic> _$TeacherMonthSalaryToJson(
    TeacherMonthSalary instance) =>
    <String, dynamic>{
      'ct': instance.salary,
    };

class TeacherReservations {
  int resCode;
  int resUserCode;
  String resToDate;
  int resTchrCode;
  int resStdCode;
  int resCrsCode;
  String resPaidprice;
  String resTchrPercent;
  int resRoomCode;
  String resTimeStart;
  String resTimeEnd;
  String resTchrNote;
  String resAdminNote;
  String btnResEdit;
  String resIsConfirmed;
  String isSmsSent;
  String resIsPaid;
  String resTchrIsPaid;
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
  int cCode;
  String cName;
  String cActive;
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

  TeacherReservations({
    this.resCode,
    this.resUserCode,
    this.resToDate,
    this.resTchrCode,
    this.resStdCode,
    this.resCrsCode,
    this.resPaidprice,
    this.resTchrPercent,
    this.resRoomCode,
    this.resTimeStart,
    this.resTimeEnd,
    this.resTchrNote,
    this.resAdminNote,
    this.btnResEdit,
    this.resIsConfirmed,
    this.isSmsSent,
    this.resIsPaid,
    this.resTchrIsPaid,
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
    this.cCode,
    this.cName,
    this.cActive,
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
    this.tActive,
  });

  factory TeacherReservations.fromJson(Map<String, dynamic> json) =>
      _$TeacherReservationsFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherReservationsToJson(this);
}

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
      resCode: int.parse(json['res_code']),
      resUserCode: int.parse(json['res_u_code']),
      resToDate: json['res_todate'],
      resTchrCode: int.parse(json['res_teach_code']),
      resStdCode: int.parse(json['res_std_code']),
      resCrsCode: int.parse(json['res_cors_code']),
      resPaidPrice: json['res_paid_price'],
      resRoomCode: int.parse(json['res_room_code']),
      resTimeStart: json["res_time_start"],
      resTimeEnd: json['res_time_end'],
      resTchrNote: json['res_teach_note'],
      resAdminNote: json['res_admin_note'],
      btnResEdit: json['btn_res_edit'],
      resIsConfirmed: json['res_is_confirmed'],
      isSmsSent: json['is_sms_sent'],
      resIsPaid: json['res_is_paid'],
      resTchrPercent: json['res_teacher_percent'],
      resTchrIsPaid: json['res_teach_is_paid'])
      ;
      
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'res_code': instance.resCode,
      'res_u_code': instance.resUserCode,
      'res_todate': instance.resToDate,
      'res_teach_code': instance.resTchrCode,
      'res_std_code': instance.resStdCode,
      'res_cors_code': instance.resCrsCode,
      'res_paid_price': instance.resPaidPrice,
      'res_teacher_percent': instance.resTchrPercent,
      'res_room_code': instance.resRoomCode,
      'res_time_start': instance.resTimeStart,
      'res_time_end': instance.resTimeEnd,
      'res_teach_note': instance.resTchrNote,
      'res_admin_note': instance.resAdminNote,
      'btn_res_edit': instance.btnResEdit,
      'res_is_confirmed': instance.resIsConfirmed,
      'is_sms_sent': instance.isSmsSent,
      'res_is_paid': instance.resIsPaid,
      'res_teach_is_paid': instance.resTchrIsPaid
    };
TeacherReservationsMonthlyHours _$TeacherReservationsMonthlyHoursFromJson(
    Map<String, dynamic> json) {
  return TeacherReservationsMonthlyHours(
    monthlyHours: json['ct'],
    );
}

Map<String, dynamic> _$TeacherReservationsMonthlyHoursToJson(
    TeacherReservationsMonthlyHours instance) =>
    <String, dynamic>{
      'ct': instance.monthlyHours,
    };
TeacherReservationsMonthlyConfirmedHours _$TeacherReservationsMonthlyConfHoursFromJson(
    Map<String, dynamic> json) {
  return TeacherReservationsMonthlyConfirmedHours(
    monthlyConfrimedHours: json['ct'],
    );
}

Map<String, dynamic> _$TeacherReservationsMonthlyConfHoursToJson(
    TeacherReservationsMonthlyConfirmedHours instance) =>
    <String, dynamic>{
      'ct': instance.monthlyConfrimedHours,
    };
 TeacherReservations _$TeacherReservationsFromJson(Map<String, dynamic> json) {
  return TeacherReservations(
      resCode: int.parse(json['res_code']),
      resUserCode: int.parse(json['res_u_code']),
      resToDate: json['res_todate'],
      resTchrCode: int.parse(json['res_teach_code']),
      resStdCode: int.parse(json['res_std_code']),
      resCrsCode: int.parse(json['res_cors_code']),
      resPaidprice: json['res_paid_price'],
      resTchrPercent: json['res_teacher_percent'],
      resRoomCode: int.parse(json['res_room_code']),
      resTimeStart: json['res_time_start'],
      resTimeEnd: json['res_time_end'],
      resTchrNote: json['res_teach_note'],
      resAdminNote: json['res_admin_note'],
      btnResEdit: json['btn_res_edit'],
      resIsConfirmed: json['res_is_confirmed'],
      isSmsSent: json['is_sms_sent'],
      resIsPaid: json['res_is_paid'],
      resTchrIsPaid: json['res_teach_is_paid'],
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
      stdBalance: json['st_balance'],
      cCode: int.parse(json['c_code']),
      cName: json['c_name'],
      cActive: json['c_active'],
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
      tActive: json['te_active']);
}

Map<String, dynamic> _$TeacherReservationsToJson(
        TeacherReservations instance) =>
    <String, dynamic>{
      'res_code': instance.resCode,
      'res_u_code': instance.resUserCode,
      'res_todate': instance.resToDate,
      'res_teach_code': instance.resTchrCode,
      'res_std_code': instance.resStdCode,
      'res_cors_code': instance.resCrsCode,
      'res_paid_price': instance.resPaidprice,
      'res_teacher_percent': instance.resTchrPercent,
      'res_room_code': instance.resRoomCode,
      'res_time_start': instance.resTimeStart,
      'res_time_end': instance.resTimeEnd,
      'res_teach_note': instance.resTchrNote,
      'res_admin_note': instance.resAdminNote,
      'btn_res_edit': instance.btnResEdit,
      'res_is_confirmed': instance.resIsConfirmed,
      'is_sms_sent': instance.isSmsSent,
      'res_is_paid': instance.resIsPaid,
      'res_teach_is_paid': instance.resTchrIsPaid,
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
      'st_balance': instance.stdBalance,
      'c_code': instance.cCode,
      'c_name': instance.cName,
      'c_active': instance.cActive,
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


class TeacherReservationsList {
  List<TeacherReservations> tr;

  TeacherReservationsList({this.tr});

  factory TeacherReservationsList.fromJson(List<dynamic> json) {
    return TeacherReservationsList(
        tr: json
            .map((e) => TeacherReservations.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

 
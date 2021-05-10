 import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class User {

  int uCode;
  String uFname;
  String uSex;
  String uEmail;
  String uUsername;
  String uPassword;
  String uType;
  String uBirthday;
  String uAddress;
  String uScrPriv;
  String uID;
  String uBtnPriv;
  String uActive;
  User({
    this.uCode,
    this.uFname,
    this.uSex,
    this.uEmail,
    this.uUsername,
    this.uPassword,
    this.uType,
    this.uBirthday,
    this.uAddress,
    this.uScrPriv,
    this.uID,
    this.uBtnPriv,
    this.uActive,
  });


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
  }

  @JsonSerializable()
  class UserList {
  List<User> users;

  UserList({this.users});
  factory UserList.fromJson(List<dynamic> json) {
  return UserList(
  users: json
      .map((e) => User.fromJson(e as Map<String, dynamic>))
      .toList());
  }
  }

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      uCode: int.parse(
          json['u_code']
          ),
      uFname: json['u_fname'],
      uSex: json['u_sex'],
      uEmail: json['u_email'],
      uUsername: json['u_username'],
      uPassword: json['u_password'],
      uBirthday: json['u_birthday'],
      uType: json['u_type'],
      uAddress: json['u_address'],
      uScrPriv: json['u_scr_priv'],
      uID: json['u_ID'],
      uBtnPriv: json['u_btn_priv'],
      uActive: json['u_active']
      );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'u_code': instance.uCode,
  'u_fname':  instance.uFname,
  'u_sex': instance.uSex,
  'u_email': instance.uEmail,
  'u_username': instance.uUsername,
  'u_password': instance.uPassword,
  'u_type': instance.uType,
  'u_birthday': instance.uBirthday,
  'u_address': instance.uAddress,
  'u_scr_priv': instance.uScrPriv,
  'u_ID': instance.uID,
  'u_btn_priv': instance.uBtnPriv,
  'u_active': instance.uActive
}; 
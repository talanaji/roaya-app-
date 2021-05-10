import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Room {
  int roomCode;
  String roomName;
  String roomActive;
  Room({
    this.roomCode,
    this.roomName,
    this.roomActive,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

@JsonSerializable()
class RoomList {
  List<Room> rooms;

  RoomList({this.rooms});
  factory RoomList.fromJson(List<dynamic> json) {
    return RoomList(
        rooms:
            json.map((e) => Room.fromJson(e as Map<String, dynamic>)).toList());
  }
}

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
      roomCode: int.parse(json['room_code']),
      roomName: json['room_name'],
      roomActive: json['room_active']
      );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'room_code': instance.roomCode,
      'room_name': instance.roomName,
      'room_active': instance.roomActive
    };
 
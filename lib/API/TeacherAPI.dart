import 'network.dart';

const String TeacherAPIURL = '/Teachers_ci/android_teacher_profile/$pass/';

class TeacherAPI {
  Future<dynamic> getTeachers() async {
    Network network = Network('$TeacherAPIURL');
    var teacherData = await network.getData();
    return teacherData;
  }

  Future<dynamic> getTeacherDetails(int userCode) async {
    Network network = Network('$TeacherAPIURL$userCode');
    var teacherData = await network.getData();
    return teacherData;
  }
}

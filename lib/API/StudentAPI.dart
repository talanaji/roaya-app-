import 'network.dart';

//const String StudentDropDownListAPIURL = 'Teachers_ci/android_teacher_profile/12345600/';
const String StudentAPIURL = '/Teachers_ci/android_get_students/$pass';

class StudentAPI {
  Future<dynamic> getStudents(String filter) async {
    Network network = Network('$StudentAPIURL/$filter');
    var teacherData = await network.getData();
    
    print(teacherData);
    return teacherData;
  }

  Future<dynamic> getStudentDetails(int userCode) async {
    Network network = Network('$StudentAPIURL$userCode');
    var teacherData = await network.getData();
    return teacherData;
  }
}

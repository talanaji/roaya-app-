import 'network.dart';

const String CourseAPIURL = '/Teachers_ci/android_get_corses/$pass';

class CourseAPI {
  Future<dynamic> getCourses() async {
    Network network = Network('$CourseAPIURL');
    var courseData = await network.getData();
    return courseData;
  }

  Future<dynamic> getCourseDetails(int userCode) async {
    Network network = Network('$CourseAPIURL$userCode');
    var courseData = await network.getData();
    return courseData;
  }
}

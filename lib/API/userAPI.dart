import 'network.dart';

const String userAPIURL = '/Login/userDetails/';

class UserAPI {
  Future<dynamic> getUsers() async {
    Network network = Network('$userAPIURL');
    var userData = await network.getData();
    return userData;
  }

  Future<dynamic> getUserDetails(int userCode) async {
     Network network = Network('$userAPIURL$userCode');
    var userData = await network.getData();
    return userData;
  }
}

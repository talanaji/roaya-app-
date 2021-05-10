import 'network.dart';

const String ReservationAPIURL = '/Login/userDetails/';
const String MonthlyHourAPIURL="/Teachers_ci/android_monthly_hours/$pass/";
const String MonthlyHourConfAPIURL="/Teachers_ci/android_confirm_hours/$pass/";
const String MonthlySalaryAPIURL="/Teachers_ci/android_confirm_hours/$pass/";
const String TeacherReservationsAPIURL = "/Teachers_ci/android_today_program/$pass/";
const String MyReservationsAPIURL = "/Teachers_ci/android_reserv_programs/$pass/";
class ReservationAPI {
  Future<dynamic> getReservations() async {
    Network network = Network('$ReservationAPIURL');
    var reservationData = await network.getData();
    return reservationData;
  }

  Future<dynamic> getReservationDetails(int userCode) async {
    Network network = Network('$ReservationAPIURL$userCode');
    var reservationData = await network.getData();
    return reservationData;
  }
  Future<dynamic> getMonthlyHours(int userCode) async {
    Network network = Network('$MonthlyHourAPIURL$userCode');
    var reservationData = await network.getData();
    return reservationData;
  }
  Future<dynamic> getMonthlyConfHours(int userCode) async {
    Network network = Network('$MonthlyHourConfAPIURL$userCode');
    var reservationData = await network.getData();
    return reservationData;
  }
  Future<dynamic> getTeacherReservations(int userCode) async {
    Network network = Network('$TeacherReservationsAPIURL$userCode');
    var reservationData = await network.getData();
    return reservationData;
  }
  Future<dynamic> getMyReservations(int userCode,String month) async {
    if(month=="00")
      {
        Network network = Network('$MyReservationsAPIURL$userCode');
        var reservationData = await network.getData();
        return reservationData;
      }
    else {
      Network network = Network(
          '$MyReservationsAPIURL$userCode/$month'
          );
      var reservationData = await network.getData(
      );
      return reservationData;
    }
  }
  Future<dynamic> getMonthSalary(int userCode) async {
    Network network = Network('$MonthlySalaryAPIURL$userCode');
    var reservationData = await network.getData();
    return reservationData;
  }

}

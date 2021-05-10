import 'dart:convert';
import 'package:Roaya/API/ReservationAPI.dart';
import 'package:Roaya/API/userAPI.dart';
import 'package:Roaya/Screens/AddReservation.dart';
import 'package:Roaya/Screens/EditReservation.dart';
import 'package:Roaya/Screens/ViewMyReservations.dart';
import 'package:Roaya/Screens/drawer.dart';
import 'package:Roaya/animation/FadeAnimation.dart';
import 'package:Roaya/classes/reservation.dart';
import 'package:Roaya/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../login_page.dart';

class TeacherPage extends StatefulWidget {
  final String username;
  final int userCode;
  TeacherPage({this.userCode, this.username});
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  UserList userList = UserList();
  TeacherReservationsMonthlyHours resTeList = TeacherReservationsMonthlyHours();
  TeacherReservationsMonthlyConfirmedHours trchList =
      TeacherReservationsMonthlyConfirmedHours();
  TeacherMonthSalary salary = TeacherMonthSalary();
  TeacherReservationsList trList = TeacherReservationsList();

  void getTRData() async {
    var trJson = await ReservationAPI().getTeacherReservations(widget.userCode);
    print(trJson);
    var trMap = json.decode(trJson);
    setState(() {
      trList = TeacherReservationsList.fromJson(trMap);
      print(trMap);
    });
  }

  void getUserData() async {
    var userJson = await UserAPI().getUserDetails(widget.userCode);
    // print(userJson);

    var userMap = json.decode(userJson);
    //print(userMap);
    setState(() {
      return userList = UserList.fromJson(userMap);
    });
  }

  void getMonthlyHour() async {
    var monthlyhourJson =
        await ReservationAPI().getMonthlyHours(widget.userCode);
    //print(monthlyhourJson);

    var monthMap = json.decode(monthlyhourJson);
    //print(monthMap);
    setState(() {
      return resTeList = TeacherReservationsMonthlyHours.fromJson(monthMap);
    });
  }

  void getMonthlyConfHour() async {
    var monthlyConfhourJson =
        await ReservationAPI().getMonthlyConfHours(widget.userCode);
    var monthConfMap = json.decode(monthlyConfhourJson);
    setState(() {
      return trchList =
          TeacherReservationsMonthlyConfirmedHours.fromJson(monthConfMap);
    });
  }

  void getMonthlySalary() async {
    var salaryJson = await ReservationAPI().getMonthSalary(widget.userCode);
    var salaryMap = json.decode(salaryJson);
    setState(() {
      return salary = TeacherMonthSalary.fromJson(salaryMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getMonthlyHour();
    getTRData();
    getMonthlyConfHour();
    getMonthlySalary();
  }

  Icon actionIcon = Icon(Icons.search);

  Widget appBarTitle = Text(
    "לוח בקרה -ראיה",
    style: GoogleFonts.rubik(),
  );

  filterButton() {
    return PopupMenuButton(
      icon: Icon(
        Icons.sort,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: <Widget>[
                Icon(Icons.add),
                SizedBox(width: 10),
                Text(
                  "הוספת שיעור",
                  style: GoogleFonts.rubik(),
                )
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: <Widget>[
                Icon(Icons.view_list),
                SizedBox(width: 10),
                Text(
                  "הצג שיעורים שלי",
                  style: GoogleFonts.rubik(),
                )
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Directionality(
                      // add this
                      textDirection: TextDirection.rtl, // set this property
                      child: AddReservation(
                        username: username,
                        userCode: widget.userCode,
                      ))));
        } else if (value == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Directionality(
                    // add this
                    textDirection: TextDirection.rtl, // set this property
                    child: ViewMyReservations(
                      username: username,
                      userCode: widget.userCode,
                    ))),
          );
        } else {}
      },
      offset: Offset(0, 50),
    );
  }

  Drawers _drawers = Drawers();

  @override
  Widget build(BuildContext context) {
    //Choice _selectedChoice = choices[0]; // The app's "state"./
    //int selectedMenu;

    if (userList == null ||
        userList.users == null ||
        userList.users.length == 0) {
      return new WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            drawer: _drawers.stylishDrawer(context, username, usercode),
            appBar: AppBar(
              backgroundColor: Color(0xFFEEA150),
              title: appBarTitle,
              actions: <Widget>[
                filterButton(),
              ],
            ),
          ));
    } else {
      return new WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              drawer: _drawers.stylishDrawer(context, username, usercode),
              appBar: AppBar(
                backgroundColor: Color(0xFFEEA150),
                title: appBarTitle,
                actions: <Widget>[
                  filterButton(),
                ],
              ),
              body:
                  //GridView.count(
                  StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                children: <Widget>[
                  FadeAnimation(
                      0.5,
                      Card(
                        elevation: 16.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Color(0xFF62C19A).withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            title: Text(
                              'ברוך הבא ' + userList.users[0].uFname,
                              style: GoogleFonts.rubik(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                  FadeAnimation(
                    0.5,
                    Card(
                        elevation: 16.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Color(0xFFadadad).withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            title: Column(
                              children: <Widget>[
                                Material(
                                    color: Color(0xFF62C19A),
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                          IconData(57746,
                                              fontFamily: 'MaterialIcons'),
                                          color: Colors.white,
                                          size: 30.0),
                                    )),
                                Text(
                                    'שעות חודש זה: ' +
                                        resTeList.monthlyHours.toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                    )),
                                Text(
                                    'שעות מאושרת  ' +
                                        trchList.monthlyConfrimedHours
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.rubik(
                                      color: Colors.white70,
                                    )),
                              ],
                            ),
                          ),
                        )),
                  ),
                  FadeAnimation(
                    0.5,
                    Card(
                        elevation: 16.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Color(0xFFadadad).withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            title: Column(
                              children: <Widget>[
                                Material(
                                    color: Colors.amber,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(
                                          IconData(57895,
                                              fontFamily: 'MaterialIcons'),
                                          color: Colors.white,
                                          size: 30.0),
                                    )),
                                Padding(padding: EdgeInsets.only(bottom: 16.0)),
                                Text('משכורת חודש זה',
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                    )),
                                Text(
                                  salary.salary.toString(),
                                  style: GoogleFonts.rubik(color: Colors.black),
                                ),
                                Text('שיקל לחודש זה',
                                    style: GoogleFonts.rubik(
                                      color: Colors.white70,
                                    )),
                              ],
                            ),
                          ),
                        )),
                  ),
                  _buildTile(Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'שעות היום ',
                                style: GoogleFonts.rubik(),
                              ),
                              DialogButton(
                                color: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.refresh,
                                  ),
                                ),
                                onPressed: () {
                                  getTRData();
                                },
                              )
                            ],
                          ),
                          Flexible(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: (trList == null ||
                                        trList.tr == null ||
                                        trList.tr.length == 0)
                                    ? 0
                                    : trList.tr.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Directionality(
                                                        // add this
                                                        textDirection: TextDirection
                                                            .rtl, // set this property

                                                        child: EditReservation(
                                                          userCode:
                                                              widget.userCode,
                                                          resCode: trList
                                                              .tr[index]
                                                              .resCode,
                                                          resTchrNote: trList
                                                              .tr[index]
                                                              .resTchrNote,
                                                          resIsConfirmed: trList
                                                              .tr[index]
                                                              .resIsConfirmed,
                                                          tCode: trList
                                                              .tr[index].tCode,
                                                          tName: trList
                                                              .tr[index].tName,
                                                          stdCode: trList
                                                              .tr[index]
                                                              .stdCode,
                                                          stdName: trList
                                                              .tr[index]
                                                              .stdName,
                                                          stdPhone1: trList
                                                              .tr[index]
                                                              .stdPhone1,
                                                          stdSmsSub: trList
                                                              .tr[index]
                                                              .stdSmsSub,
                                                        ))),
                                          ),
                                      child: Card(
                                          elevation: 16.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          color: index % 2 == 0
                                              ? Color(0xFF62C19A)
                                                  .withOpacity(0.8)
                                              : Color(0xFFEEA150)
                                                  .withOpacity(0.9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  trList.tr[index].cName +
                                                      " / " +
                                                      trList.tr[index].stdName,
                                                  style: GoogleFonts.rubik(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  "מ: " +
                                                      trList.tr[index]
                                                          .resTimeStart +
                                                      " עד  " +
                                                      trList
                                                          .tr[index].resTimeEnd,
                                                  style: GoogleFonts.rubik(),
                                                ),
                                              ],
                                            ),
                                          )));
                                }),
                          )
                        ]),
                  ))
                ],
                staggeredTiles: [
                  StaggeredTile.extent(2, 80.0),
                  StaggeredTile.extent(1, 200.0),
                  StaggeredTile.extent(1, 200.0),
                  StaggeredTile.extent(2, 700),
                ],
              )));
    }
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}

import 'dart:convert';
import 'package:Roaya/API/TeacherAPI.dart';
import 'package:Roaya/API/userAPI.dart';
import 'package:Roaya/Screens/drawer.dart';
import 'package:Roaya/animation/FadeAnimation.dart';
import 'package:Roaya/classes/teacher.dart';
import 'package:Roaya/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  final int userCode;
  final String userName;
  ProfilePage({this.userCode, this.userName});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<ProfilePage> {
  UserList userList = UserList();

  void getUserData() async {
    var userJson = await UserAPI().getUserDetails(widget.userCode);
    print(userJson);

    var userMap = json.decode(userJson);
    print(userMap);
    setState(() {
      userList = UserList.fromJson(userMap);
    });
  }

  Teacher tchr = Teacher();

  void getTeacherData() async {
    var tJson = await TeacherAPI().getTeacherDetails(widget.userCode);
    print(tJson);

    var tMap = json.decode(tJson);
    print(tMap);
    setState(() {
      tchr = Teacher.fromJson(tMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getTeacherData();
  }

  Drawers _drawers = Drawers();
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            drawer: _drawers.stylishDrawer(
                context, widget.userName, widget.userCode),
            appBar: AppBar(
              backgroundColor: Color(0xFFEEA150),
              title: Text("פרופיל שלי", style: GoogleFonts.rubik()),
              actions: <Widget>[],
            ),
            body: getUser()));
  }

  Widget getUser() {
    if (userList == null ||
        userList.users == null ||
        userList.users.length == 0) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('אנא המתן  ... מוריד את הנתונים',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.rubik())
          ],
        ),
      );
    } else {
      if (tchr.tCode != null) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomHeader(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        0.5,
                        Center(
                          child: Text(
                            tchr.tName,
                            style: GoogleFonts.rubik(
                                fontSize: 35, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Divider(),
                      FadeAnimation(
                        0.7,
                        ListTile(
                          title: Text("דואר אלקטרוני",
                              style: GoogleFonts.rubik()),
                          subtitle:
                              Text(tchr.tEmail, style: GoogleFonts.rubik()),
                          leading: Icon(Icons.email),
                        ),
                      ),
                      FadeAnimation(
                        0.9,
                        ListTile(
                          title: Text("מס טלפון", style: GoogleFonts.rubik()),
                          subtitle:
                              Text(tchr.tPhone1, style: GoogleFonts.rubik()),
                          leading: Icon(Icons.phone),
                        ),
                      ),
                      FadeAnimation(
                        1.1,
                        ListTile(
                          title: Text("ישוב", style: GoogleFonts.rubik()),
                          subtitle:
                              Text(tchr.tTown, style: GoogleFonts.rubik()),
                          leading: Icon(Icons.web),
                        ),
                      ),
                      FadeAnimation(
                        1.3,
                        ListTile(
                          title: Text("תאריך תחילה",
                              style: GoogleFonts.rubik()),
                          subtitle:
                              Text(tchr.tRegDate, style: GoogleFonts.rubik()),
                          leading: Icon(Icons.calendar_view_day),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        );
      } else {
        return null;
      }
      //"assets/avatar.jpg",

    }
  }
}

class HeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          margin: EdgeInsets.only(top: 130),
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                blurRadius: 90,
                spreadRadius: 20,
                color: Colors.blueGrey.shade800)
          ]),
        ),
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            margin: EdgeInsets.only(top: 5),
            height: 250,
            color: Colors.white,
          ),
        ),
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: 240,
            color: Color(0xFFEEA150),
          ),
        ),
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.lineTo(sw, 0);
    path.lineTo(sw, sh);
    path.cubicTo(sw, sh * 0.7, 0, sh * 0.8, 0, sh * 0.55);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.lineTo(4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.lineTo(sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        HeaderBackground(),
        FadeAnimation(
          0.3,
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.only(top: 115),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage("assets/avatar.jpg")),
              // borderRadius: BorderRadius.circular(35),
            ),
          ),
        )
      ],
    );
  }
}

import 'dart:io';
import 'dart:ui';
import 'package:Roaya/Screens/ProfilePage.dart';
import 'package:Roaya/Screens/TeacherPage.dart';
import 'package:Roaya/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';   

class Drawers {
  stylishDrawer(context, String username, int usercode) {
    return ClipPath(
      clipper: DrawerStyle(),
      child: Container(
        width: 300,
        height: 640,
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration:
                    BoxDecoration(color:  Color(0xFFEEA150).withOpacity(0.7)),
              ),
            ),
            Container(
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      /*Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ProfileScreen()));*/
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/avatar.jpg",
                ), 
              ),
                        ),
                        Text(
                          username,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 0.5,
                    color: Colors.white,
                  ),
                  _drawerWidget(context, 'דף ראשי', Icons.home),
                  _drawerWidget(
                      context, 'פרופיל שלי', Icons.add_circle_outline, ),
                  _drawerWidget(
                      context, 'צא', Icons.add_circle_outline),
                  Divider(
                    height: 0.5,
                    color: Colors.white,
                  ),
                  _drawerWidget(
                      context, 'מי אנחנו', Icons.web),
                  _drawerWidget(
                      context, 'אתר אינטרנט', Icons.web),
                   SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _drawerWidget(context, title, icon) {
    return ListTile(
      onTap: () {
        
        switch (title) {
          case 'דף ראשי':
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => Directionality(
                    // add this

                    textDirection: TextDirection.rtl, // set this property
                    child: TeacherPage(userCode: usercode,))));
            break;

          case 'פרופיל שלי':
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => Directionality(
                    // add this
                    textDirection: TextDirection.rtl, // set this property
                    child: ProfilePage(userCode: usercode, userName: username,))));
            break;

          case  'צא':
            exit(0);
            break;

          case 'מי אנחנו':
         /*   Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) => AllCompanies(
                        title: 'Companies In USA', country: 'usa')));*/

            break;
          case 'אתר אינטרנט':
            _launchURL("http://www.roaya.co.il/");

            break;
           default:
            break;
        }
      },
      leading: Icon(
        icon,
        color:Colors.white,
      ),
      title: Text('$title',  style: GoogleFonts.rubik( color: Colors.white,
                                      )),
    );
  }
}

class DrawerStyle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 40);
    path.quadraticBezierTo(
        size.width - 50, size.height - 80, size.width, size.height);
    path.quadraticBezierTo(size.width - 100, size.height / 2, size.width, 0);
    path.quadraticBezierTo(size.width / 2, 30, 0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return null;
  }
}

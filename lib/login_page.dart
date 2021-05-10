import 'dart:convert';

import 'package:Roaya/API/network.dart';
import 'package:Roaya/Screens/AdminPage.dart';
import 'package:Roaya/Screens/TeacherPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'animation/FadeAnimation.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:http/http.dart' as http;

String username = '';
int usercode;

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class MyCustomCard extends StatelessWidget {
  MyCustomCard({this.colors});

  final MaterialColor colors;

  Widget build(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.center,
      height: 144.0,
      width: 360.0,
      decoration: new BoxDecoration(
        color: colors.shade50,
        border: new Border.all(color: new Color(0xFF9E9E9E)),
      ),
      child: new FlutterLogo(size: 100.0, colors: colors),
    );
  }
}

class _LoginScreenState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;

  TextEditingController uUsername = new TextEditingController();

  TextEditingController pass = new TextEditingController();
  _onLoginFailedAlert(context) {
    Alert(context: context, title: "خطأ : ", desc: "يرجى التأكد من البيانات ",style: AlertStyle(titleStyle: GoogleFonts.rubik(),descStyle:GoogleFonts.rubik(),),
    buttons: [
        DialogButton(
          color:  Color(0xFFEEA150),
          child: Text(
            "رجوع",
            style: GoogleFonts.rubik(color: Colors.white, fontSize: 14, ),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )])
        .show();
  }

  static final boxDecoration = BoxDecoration(
      color: Color(0xFFEEA150),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 5,
            offset: Offset(0, 8),
            spreadRadius: 2)
      ]);

  @override
  void initState() {
    super.initState();
    animationState();
  }

  void animationState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _frontScale = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
    Future<List> _login() async {
      final response = await http.get(
        "$baseUrl/Login/authapp/" +
            uUsername.text +
            "/" +
            pass.text,
      );
      print(response.request.url);
      print(uUsername.text);
      print(pass.text);
      print(response.body);
      var datauser = json.decode(response.body);

      // if(datauser.length==0){
      if (response.body == "0") {
        _onLoginFailedAlert(context);
        //setState(() {
        //});
      } else {
        usercode = int.parse(datauser[0]['u_code']);
        username = datauser[0]['u_username'];
        if (datauser[0]['u_type'] == "2") //teacher
        {
          print('teacher account');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Directionality(
                    // add this
                    textDirection: TextDirection.rtl, // set this property
                    child: TeacherPage(
                      userCode: usercode,
                      username: username,
                    ))),
          );
        } else if (datauser[0]['u_type'] == "1") //admin
        {
          print('admin account');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Directionality(
                    // add this
                    textDirection: TextDirection.rtl, // set this property
                    child: AdminPage(username: username))),
          );
        }
      }

      return datauser;
    }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/dogbackground.png'))),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Hero(
                  tag: 'Roaya',
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 20,
                  right: 20,
                  bottom: 130,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        new AnimatedBuilder(
                          child: buildloginForm(),
                          animation: _frontScale,
                          builder: (BuildContext context, Widget child) {
                            final Matrix4 transform = new Matrix4.identity()
                              ..scale(1.0, _frontScale.value, 1.0);
                            return new Transform(
                              transform: transform,
                              alignment: FractionalOffset.center,
                              child: child,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                 
              ],
            ),
          ),
        ),
      ),
    );
  }

  isEnoughRoomForTypewriter(width) => width > 40;

  buildloginForm() {
    return Card(
        color: Colors.white,
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1,
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    "כניסה",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                        color: Color(0xFFEEA150),
                        fontWeight: FontWeight.bold, 
                        fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              emailWidget(),
              const SizedBox(height: 20),
              passwordWidget(),
               
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _login();
                  /* Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => TeacherPage(userCode: 1,)));*/
                },
                child: ControlledAnimation(
                  duration: Duration(milliseconds: 400),
                  tween: Tween(begin: 0.0, end: 80.0),
                  builder: (context, height) {
                    return ControlledAnimation(
                      duration: Duration(milliseconds: 1200),
                      delay: Duration(milliseconds: 500),
                      tween: Tween(begin: 2.0, end: 300.0),
                      builder: (context, width) {
                        return Container(
                          decoration: boxDecoration,
                          width: width,
                          height: 50,
                          child: isEnoughRoomForTypewriter(width)
                              ? Center(
                                  child: Text(
                                    'כניסה למערכת',
                                    style: GoogleFonts.rubik(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                )
                              : Container(),
                        );
                      },
                    );
                  },
                ),
              ),
               
            ],
          ),
        ));
  }


  emailWidget() {
    return FadeAnimation(
      1.3,
      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 55.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Color(0xFFadadad))),
          child: TextFormField(
            style: TextStyle(fontWeight: FontWeight.w600),
            controller: uUsername,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "שם משתמש",
              hintStyle: GoogleFonts.rubik(fontSize: 15, color: Color(0xFFadadad)),
              icon: Icon(Icons.email, color: Color(0xFFadadad)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  passwordWidget() {
    return FadeAnimation(
      1.3,
      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 55.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Color(0xFFadadad))),
          child: TextFormField(
            style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
            obscureText: true,
            controller: pass,
            decoration: InputDecoration(
                hintText: "סיסמה",
                hintStyle: GoogleFonts.rubik(
                  fontSize: 15,
                  color: Color(0xFFadadad),
                ),
                icon: Icon(Icons.lock, color: Color(0xFFadadad)),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

}

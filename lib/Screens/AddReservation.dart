import 'dart:convert';
import 'package:Roaya/API/CourseAPI.dart';
import 'package:Roaya/API/StudentAPI.dart';
import 'package:Roaya/API/network.dart';
import 'package:Roaya/Screens/TeacherPage.dart';
import 'package:Roaya/Screens/drawer.dart';
import 'package:Roaya/classes/course.dart';
import 'package:Roaya/classes/student.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart' as intl;

class AddReservation extends StatefulWidget {
  final int userCode;
  final String username;
  AddReservation({this.userCode, this.username});
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  List<DropdownMenuItem> items = [];
  String selectedValue;
   String filter = "";
  @override
  void initState() {
    super.initState();
    getStdList(filter);
    getCrsList();
  }

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController info = new TextEditingController();
  TextEditingController accountusername = new TextEditingController();
  TextEditingController notes = new TextEditingController();
  TimeOfDay startTime;
  TimeOfDay endTime;
  final _formKey = GlobalKey<FormState>();
  bool isFocus = false;
  StudentList stdlist = StudentList();
  Student stdSelected;
   void getStdList(filter) async {
    var trJson = await StudentAPI().getStudents(filter);
    print("students" + trJson);
    var trMap = json.decode(trJson);
    setState(() {
      stdlist = StudentList.fromJson(trMap);
      print(trMap);
    });
  }

  CourseList crslist = CourseList();
  Course crsSelected;

  void getCrsList() async {
    var trJson = await CourseAPI().getCourses();
    print("Courses" + trJson);
    var trMap = json.decode(trJson);
    setState(() {
      crslist = CourseList.fromJson(trMap);
      print(trMap);
    });
  }

  void addRes(String stdCode, String crsCode, String userCode,
      String dateTimeStart, String dateTimeEnd, String resNote) async {
    final response = await http.get(
      "$baseUrl/Teachers_ci/android_AddEdit_reserv/12345600/$stdCode/$crsCode/$userCode/0/$dateTimeStart/$dateTimeEnd/$resNote",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );
    print(response.request.url);
    print(response.body);

    if (response.body == "1") {
      Alert(title: "שיעור קיים", context: context, buttons: [
        DialogButton(
          child: Text(
            "חזרה",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ]).show();
      //setState(() {
      //});
    } else {
      if (response.body == "2") {
        Alert(
          title: "אין חדר פנוי",
          context: context,
          buttons: [
            DialogButton(
              child: Text(
                "חזרה",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        //setState(() {
        //});
      } else {
        if (response.body == "3") {
          Alert(
              title: "לא ניתן להכניס שעת סיום לפני שעת התחלה",
              context: context,
              buttons: [
                DialogButton(
                  child: Text(
                    "חזרה",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ]).show();
          //setState(() {
          //});
        } else {
          if (response.body == "4") {
            print("נרשם בהצלחה");
            Alert(title: "נרשם בהצלחה", context: context, buttons: [
              DialogButton(
                child: Text(
                  "מאשר",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Directionality(
                          // add this
                          textDirection: TextDirection.rtl, // set this property
                          child: TeacherPage(
                            userCode: widget.userCode,
                          )),
                    )),
                width: 120,
              )
            ]).show();
            //setState(() {
            //});
          }
        }
      }
    }
  }

  Drawers _drawers = Drawers();
  bool isVisible = false;
  int serviceBox = 1;
  List<Widget> serviceList = [];
  String ex1 = "No value selected";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:
            _drawers.stylishDrawer(context, widget.username, widget.userCode),
        appBar: AppBar(
          backgroundColor: Color(0xFFEEA150),
          title: Text("הוספת שיעור", style: GoogleFonts.rubik()),
        ),
        body: Form(
            key: _formKey,
            child: new ListView(shrinkWrap: true, children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  HeaderBackground(),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.user),
                          Text("     שם תלמיד ", style: GoogleFonts.rubik()),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            getStdList(text);
                          });
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusColor: Color(0xff0677BD),
                            suffixIcon: Icon(Icons.search),
                            hintText: "כתוב שם תלמיד לחפש ברשימה",
                            hintStyle: GoogleFonts.rubik(
                                color:
                                    isFocus ? Color(0xff0677BD) : Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0677BD)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: new Border.all(
                                color: Colors.grey.shade200,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: DropdownButton<Student>(
                          value: (stdlist.students.contains(stdSelected))
                              ? stdSelected
                              : null,
                          isExpanded: true,
                          items: stdlist.students?.map((Student value) {
                                return new DropdownMenuItem<Student>(
                                  value: value,
                                  child: new Container(
                                    child: Text(value.stdName,
                                        style: GoogleFonts.rubik()),
                                    alignment: Alignment.centerRight,
                                  ),
                                );
                              })?.toList() ??
                              [],
                          onChanged: (Student value) {
                            setState(() {
                              stdSelected = value;
                            });
                          },
                          hint: Row(
                            children: <Widget>[
                              Text("      בחר שם תלמיד ...",
                                  style: GoogleFonts.rubik())
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.solidStickyNote,
                          ),
                          Text('     מקצוע    ', style: GoogleFonts.rubik())
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: new Border.all(
                                color: Colors.grey.shade200,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: DropdownButton<Course>(
                          value: crsSelected,
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          hint: Row(
                            children: <Widget>[
                              Text("      בחר מקצוע ...",
                                  style: GoogleFonts.rubik())
                            ],
                          ),
                          //value: genderSelected,
                          isExpanded: true,
                          items: crslist.courses?.map((Course value) {
                                return new DropdownMenuItem<Course>(
                                  value: value,
                                  child: new Container(
                                    child: Text(value.cName,
                                        style: GoogleFonts.rubik()),
                                    alignment: Alignment.centerRight,
                                  ),
                                );
                              })?.toList() ??
                              [],
                          onChanged: (Course value) {
                            setState(() {
                              crsSelected = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.clock,
                          ),
                          Text('     שעת התחלה ', style: GoogleFonts.rubik())
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      DateTimeField(
                        validator: (value) {
                          if (value == null) {
                            Alert(
                                    title: "חייב להכנית שעת התחלה",
                                    context: context)
                                .show();
                          }
                          return null;
                        },
                        onShowPicker: (context, currentValue) async {
                          startTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );

                          return DateTimeField.convert(startTime);
                        },
                        format: intl.DateFormat("HH:mm"),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusColor: Color(0xff0677BD),
                            suffixIcon: Icon(
                              Icons.timer,
                              color: isFocus ? Color(0xff0677BD) : Colors.grey,
                            ),
                            hintText: 'בחר שעה',
                            hintStyle: GoogleFonts.rubik(
                                color:
                                    isFocus ? Color(0xff0677BD) : Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0677BD)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.clock,
                          ),
                          Text('      שעת סיום  ', style: GoogleFonts.rubik())
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      DateTimeField(
                        validator: (value) {
                          if (value == null) {
                            Alert(
                                    title: "חייב להכניס שעת סיום",
                                    context: context)
                                .show();
                          }
                          return null;
                        },
                        format: intl.DateFormat("HH:mm"),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusColor: Color(0xff0677BD),
                            suffixIcon: Icon(
                              Icons.timer,
                              color: isFocus ? Color(0xff0677BD) : Colors.grey,
                            ),
                            hintText: 'בחר שעה',
                            hintStyle: GoogleFonts.rubik(
                                color:
                                    isFocus ? Color(0xff0677BD) : Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0677BD)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        onShowPicker: (context, currentValue) async {
                          endTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );

                          return DateTimeField.convert(endTime);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.stickyNote,
                          ),
                          Text('     הערות', style: GoogleFonts.rubik())
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: new Border.all(
                                color: Colors.grey.shade200,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          style: GoogleFonts.rubik(),
                          decoration: InputDecoration(
                            labelText: 'הכנס הערות ...',
                          ),
                          controller: notes,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFEEA150),
                                Color(0xFFEEA150).withOpacity(0.7),
                              ],
                            ),
                          ),
                          child: Center(
                              child: AnimatedSwitcher(
                            child: IconButton(
                              onPressed: () => {
                                if (_formKey.currentState.validate())
                                  {
                                    if (crsSelected == null ||
                                        stdSelected == null ||
                                        startTime == null ||
                                        endTime == null)
                                      {
                                        Fluttertoast.showToast(
                                            msg:
                                                "לברר אם הניתונים קיימת במערכת",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIos: 1,
                                            fontSize: 16.0)
                                      }
                                    else
                                      //print(startTime.format(context))
                                      addRes(
                                          stdSelected.stdCode.toString(),
                                          crsSelected.cCode.toString(),
                                          widget.userCode.toString(),
                                          intl.DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now()) +
                                              startTime.format(context),
                                          intl.DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now()) +
                                              endTime.format(context),
                                          notes.text)
                                  }
                              },
                              icon: Icon(Icons.done,
                                  color: Colors.black.withOpacity(0.9),
                                  size: 40),
                            ),
                            duration: Duration(seconds: 2),
                          )))
                    ],
                  )),
              IgnorePointer(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.white.withOpacity(0.01),
                          ],
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: BottomBarClipper(),
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFEEA150),
                              Color(0xFFEEA150).withOpacity(0.8),
                              Color(0xFFEEA150).withOpacity(0.5),
                              Color(0xFFEEA150).withOpacity(0.3),
                              Colors.white,
                            ],
                          ),
                        ),
                        child: ClipPath(
                          clipper: BottomBarClipper(),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFFEEA150),
                                  Color(0xFFEEA150).withOpacity(0.1),
                                  Color(0xFFEEA150).withOpacity(0.1),
                                  Colors.white,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ])));
  }
}

class HeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            margin: EdgeInsets.only(top: 5),
            height: 70,
            color: Colors.black26,
          ),
        ),
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: 70,
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

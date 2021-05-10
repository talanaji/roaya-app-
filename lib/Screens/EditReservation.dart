import 'dart:core';

import 'package:Roaya/API/network.dart';
import 'package:Roaya/Screens/TeacherPage.dart';
import 'package:Roaya/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class EditReservation extends StatefulWidget {
  final int userCode;

  final int resCode;
  final String resTchrNote;
  final String resIsConfirmed;
  final int tCode;
  final String tName;
  final int stdCode;
  final String stdName;
  final String stdPhone1;
  final String stdSmsSub;
  EditReservation({
    this.userCode,
    this.resCode,
    this.resTchrNote,
    this.resIsConfirmed,
    this.tCode,
    this.tName,
    this.stdCode,
    this.stdName,
    this.stdPhone1,
    this.stdSmsSub,
  });
  @override
  _EditReservationState createState() => _EditReservationState();
}

class _EditReservationState extends State<EditReservation> {
  ConfrimChoices _selectedConfrimChoices;
  List<ConfrimChoices> _confrimChoicesList;

  @override
  void initState() {
    super.initState();
    ConfrimChoices.getconfrimChoices();

    _confrimChoicesList = ConfrimChoices.getconfrimChoices();
    _selectedConfrimChoices = _confrimChoicesList.first;
  }

  TextEditingController teacherNote = new TextEditingController();
  String isconfirmValue;
  void updateRes(
      int resCode,
      String resTchrNote,
      String resIsConfirmed,
      int tCode,
      String tName,
      int stdCode,
      String stdName,
      String stdPhone1,
      String stdSmsSub,
      int userType) async {
    if (stdPhone1 == '') {
      stdPhone1 = '100';
    }
    final response = await http.get(
        "$baseUrl/Teachers_ci/android_update_reservation/12345600/$resCode/$resTchrNote/$resIsConfirmed/$tCode/$tName/$stdCode/$stdName/$stdPhone1/$stdSmsSub/2",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        });
    print(response.request.url);
    print(response.body);
    if (response.body == "0") {
      Alert(title: "קיים שגיאה", context: context, buttons: [
        DialogButton(
          child: Text(
            "חזרה",
            style: GoogleFonts.rubik(color: Colors.white, fontSize: 14),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ]).show();
      //setState(() {
      //});
    } else {
      if (response.body == "1") {
        Alert(title: "נשמר בהצלחה", context: context, buttons: [
          DialogButton(
            child: Text(
              "מאשר",
              style: GoogleFonts.rubik(color: Colors.white, fontSize: 14),
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
      } else if (response.body == "2") {
        Alert(title: "שגיאה בפעולה נסה שנית", context: context)
            .show();
      }
    }
  }

  Widget getDropDown() {
    var items = _confrimChoicesList.map((cc) {
      return new DropdownMenuItem<ConfrimChoices>(
          value: cc,
          child: new Container(
              child: new Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Text(
              cc.name,
              style: GoogleFonts.rubik(color: Colors.black),
            ),
          ])));
    }).toList();

    return Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: new Border.all(
                color: Colors.grey.shade200,
                width: 1.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: DropdownButton<ConfrimChoices>(
            value: this._selectedConfrimChoices,
            isExpanded: true,
            onChanged: (ConfrimChoices cc) {
              setState(() {
                this._selectedConfrimChoices = cc;
              });
            },
            items: items));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFEEA150),
          title: Text("פרופיל שלי", style: GoogleFonts.rubik()),
          actions: <Widget>[],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                      child: Column(children: <Widget>[
                        Text(
                          "ערוך שיעור",
                          style: GoogleFonts.rubik(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.stdName,
                          style: GoogleFonts.rubik(
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                        ),
                        getDropDown(),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                        ),
                        TextFormField(
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintText: 'הערת מורה : ',
                              hintStyle: GoogleFonts.rubik(),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              focusColor: Color(0xFF62C19A),
                              suffixIcon:
                                  Icon(Icons.note, color: Color(0xFF62C19A)),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFEEA150)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          controller: teacherNote,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                        ),
                        DialogButton(
                          onPressed: () => updateRes(
                              widget.resCode,
                              teacherNote.text,
                              _selectedConfrimChoices.id.toString(),
                              widget.tCode,
                              widget.tName,
                              widget.stdCode,
                              widget.stdName,
                              widget.stdPhone1,
                              "אשר שיעור",
                              2),
                          color: Color(0xFFEEA150),
                          child: Text(
                            "שמור",
                            style: GoogleFonts.rubik(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        )
                      ]),
                    ),
                  )),
            ]));
    //GridView.count(
  }
}

class ConfrimChoices {
  final int id;
  final String name;

  ConfrimChoices(this.id, this.name);

  static List<ConfrimChoices> getconfrimChoices() {
    return <ConfrimChoices>[
      ConfrimChoices(1, 'ממתין לאישור'),
      ConfrimChoices(2, 'אשר שיעור'),
      ConfrimChoices(3, 'שיעור מבוטל בתשלום'),
      ConfrimChoices(4, 'שיעור מבוטל ללא חיוב'),
    ];
  }
}

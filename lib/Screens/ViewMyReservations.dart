import 'dart:convert';
import 'package:Roaya/API/ReservationAPI.dart';
import 'package:Roaya/Screens/drawer.dart';
import 'package:Roaya/animation/FadeAnimation.dart';
import 'package:Roaya/classes/reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class ViewMyReservations extends StatefulWidget {
  final int userCode;
  final String username;
  ViewMyReservations({this.userCode, this.username});
  @override
  _ViewMyReservationsState createState() => _ViewMyReservationsState();
}

class _ViewMyReservationsState extends State<ViewMyReservations> {
  TeacherReservationsList trList = TeacherReservationsList();

  void getTRData(String month) async {
    var trJson =
        await ReservationAPI().getMyReservations(widget.userCode, month);
    print(trJson);
    var trMap = json.decode(trJson);
    setState(() {
      trList = TeacherReservationsList.fromJson(trMap);
      print(trMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getTRData("00");
  }

  String selectedMonth;

  Drawers _drawers = Drawers();
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          drawer:
              _drawers.stylishDrawer(context, widget.username, widget.userCode),
          appBar: AppBar(
            backgroundColor: Color(0xFFEEA150),
            title: Text(
              "הצג שיעורים שלי",
              style: GoogleFonts.rubik(),
            ),
            actions: <Widget>[],
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
                  color: Color(0xFFadadad).withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: StaggeredGridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'שיעורים שלי',
                            style: GoogleFonts.rubik(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            DropdownButton<String>(
                              isExpanded: false,
                              value: selectedMonth,
                              items: Month.getMonths().map((Month cc) {
                                return new DropdownMenuItem<String>(
                                  value: cc.value.toString(),
                                  child: new Text(cc.title),
                                );
                              }).toList(),
                              hint: Text(
                                "בחר חודש",
                                style: GoogleFonts.rubik(),
                              ),
                              onChanged: (value) {
                                selectedMonth = value;
                                getTRData(value);
                              },
                            ),
                          ],
                        )
                      ],
                      staggeredTiles: [
                        StaggeredTile.extent(1, 50.0),
                        StaggeredTile.extent(1, 50.0),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                            return Card(
                                elevation: 16.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                color: index % 2 == 0
                                    ? Color(0xFF62C19A).withOpacity(0.8)
                                    : Color(0xFFEEA150).withOpacity(0.9),
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
                                            trList.tr[index].resTimeStart +
                                            " עד  " +
                                            trList.tr[index].resTimeEnd,
                                        style: GoogleFonts.rubik(),
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                    )
                  ]),
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 80.0),
              StaggeredTile.extent(2, 600.0),
            ],
          ),
        ));
  }
}

class Month {
  final String value;
  final String title;

  Month(this.value, this.title);
  static List<Month> getMonths() {
    var now = new DateTime.now();
    var formatter = new intl.DateFormat('MM');
    String month = formatter.format(now);
    switch (month) {
      case "01":
        {
          // statements;
          return <Month>[
            Month('12', 'דצמבר'),
            Month('01', 'ינואר'),
          ];
        }
        break;

      case "02":
        {
          //statements;

          return <Month>[
            Month('01', 'ינואר'),
            Month('02', 'פברואר'),
          ];
        }
        break;
      case "03":
        {
          //statements;

          return <Month>[
            Month('02', 'פברואר'),
            Month('03', 'מרץ'),
          ];
        }
        break;
      case "04":
        {
          //statements;

          return <Month>[
            Month('03', 'מרץ'),
            Month('04', 'אפריל'),
          ];
        }
        break;
      case "05":
        {
          //statements;

          return <Month>[
            Month('04', 'אפריל'),
            Month('05', 'מאי'),
          ];
        }
        break;
      case "06":
        {
          //statements;

          return <Month>[
            Month('05', 'מאי'),
            Month('06', 'יוני'),
          ];
        }
        break;
      case "07":
        {
          //statements;

          return <Month>[
            Month('06', 'יוני'),
            Month('07', 'יולי'),
          ];
        }
        break;
      case "08":
        {
          //statements;

          return <Month>[
            Month('07', 'יולי'),
            Month('08', 'אוגוסט'),
          ];
        }
        break;
      case "09":
        {
          //statements;

          return <Month>[
            Month('08', 'אוגוסט'),
            Month('09', 'ספטמבר'),
          ];
        }
        break;
      case "10":
        {
          //statements;

          return <Month>[
            Month('09', 'ספטמבר'),
            Month('10', 'אוקטובר'),
          ];
        }
        break;
      case "11":
        {
          //statements;

          return <Month>[
            Month('10', 'אוקטובר'),
            Month('11', 'נובמבר'),
          ];
        }
        break;
      case "12":
        {
          //statements;

          return <Month>[
            Month('11', 'נובמבר'),
            Month('12', 'דצמבר'),
          ];
        }
        break;

      default:
        {
          //statements;
          return <Month>[
            Month('00', 'הצג הכל'),
            Month('01', 'ינואר'),
            Month('02', 'פברואר'),
            Month('03', 'מרץ'),
            Month('04', 'אפריל'),
            Month('05', 'מאי'),
            Month('06', 'יוני'),
            Month('07', 'יולי'),
            Month('08', 'אוגוסט'),
            Month('09', 'ספטמבר'),
            Month('10', 'אוקטובר'),
            Month('11', 'נובמבר'),
            Month('12', 'דצמבר'),
          ];
        }
        break;
    }
  }
}

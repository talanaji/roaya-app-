import 'package:Roaya/Screens/ProfilePage.dart';
import 'package:Roaya/login_page.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts_arabic/fonts.dart';
 
class AdminPage extends StatelessWidget {
  AdminPage({this.username});
  final String username;
  @override
  Widget build(BuildContext context) {
  //  Choice _selectedChoice = choices[0]; // The app's "state".

    void _select(Choice choice) {
       // Causes the app to rebuild with the new _selectedChoice.
    //  _selectedChoice = choice;
      print(choice.value);
      if (choice.value == "logout") {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Directionality( // add this
                                                                    textDirection: TextDirection.rtl, // set this property
                                                                        child: LoginPage()),
                              ));
      }
      if (choice.value == "Profile") {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Directionality( // add this
                                                                    textDirection: TextDirection.rtl, // set this property
                                                                        child: ProfilePage()),
                              ));
      }
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'لوحة التحكم',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              ),
            ),
          automaticallyImplyLeading: false, //display back arrow
          actions: <Widget>[
            _buildTile(Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PopupMenuButton<Choice>(
                    onSelected: _select,
                    itemBuilder: (BuildContext context) {
                      return choices.map((Choice choice) {
                        //return choices.skip(2).map((Choice choice) {
                        return PopupMenuItem<Choice>(
                          value: choice,
                          child: Row(children: <Widget>[
                            Text(choice.title),
                            Icon(choice.icon)
                          ]),
                          );
                      }).toList();
                    },
                    ),
                ],
                ),
              ))
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
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'أهلا بك يا '+username,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontFamily: ArabicFonts.El_Messiri,
                                package: 'google_fonts_arabic'),
                            ),
                        ],
                        ),
                    ]),
                ),
              ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Material(
                          color: Colors.teal,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                                IconData(57746, fontFamily: 'MaterialIcons'),
                                color: Colors.white,
                                size: 30.0),
                            )),
                      Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      Text(' الساعات لهذا الشهر: 158',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.w700,
                                   fontSize: 16.0,
                                   fontFamily: ArabicFonts.El_Messiri,
                                   package: 'google_fonts_arabic')),
                      Text('5% ساعات مؤكدة ',
                               style: TextStyle(
                                   color: Colors.black45,
                                   fontFamily: ArabicFonts.El_Messiri,
                                   package: 'google_fonts_arabic')),
                    ]),
                ),
              ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Material(
                          color: Colors.amber,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                                IconData(57895, fontFamily: 'MaterialIcons'),
                                color: Colors.white,
                                size: 30.0),
                            )),
                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('معاش هذا الشهر',
                               style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.w700,
                                   fontSize: 16.0,
                                   fontFamily: ArabicFonts.El_Messiri,
                                   package: 'google_fonts_arabic')),
                      Text(
                        '1717.5',
                        style: TextStyle(color: Colors.green),
                        ),
                      Text('شيكل لهذا الشهر',
                               style: TextStyle(
                                   color: Colors.black45,
                                   fontFamily: ArabicFonts.El_Messiri,
                                   package: 'google_fonts_arabic')),
                    ]),
                ),
              ),
            _buildTile(
              ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.map),
                    title: Text(
                      'جدول اليوم ',
                      style: TextStyle(
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic'),
                      ),
                    ),
                  ListTile(
                    title: Text('Album Album Album Album Album Album '),
                    ),
                  ListTile(
                    title: Text('Phone Phone Phone Phone Phone Phone '),
                    ),
                  ListTile(
                    title: Text('Phone Phone Phone Phone Phone Phone '),
                    ),
                  ListTile(
                    title: Text('Phone Phone Phone Phone Phone Phone '),
                    ),
                ],
                ),
              )
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 80.0),
            StaggeredTile.extent(1, 200.0),
            StaggeredTile.extent(1, 200.0),
            StaggeredTile.extent(2, 700),
          ],
          ));
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

class Choice {
  const Choice({this.value, this.title, this.icon});
  final String value;
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      value: 'username',
      title: 'Admin',
      icon: IconData(59389, fontFamily: 'MaterialIcons')),
  const Choice(
      value: 'Profile',
      title: 'الحساب الشخصي',
      icon: IconData(59389, fontFamily: 'MaterialIcons')),
  const Choice(
      value: 'logout',
      title: 'تسجيل خروج',
      icon: IconData(59513, fontFamily: 'MaterialIcons')),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
          ),
        ),
      );
  }
}

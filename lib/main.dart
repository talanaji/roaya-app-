import 'package:Roaya/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart'; 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'ראיה',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: ArabicFonts.El_Messiri,
        ),
      home: Directionality( // add this
                            textDirection: TextDirection.rtl, // set this property
                                child: SplashScreen())
      ,
      );
  }
}

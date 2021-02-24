import 'package:flutter/material.dart';
import 'package:prueba_app/screens/home.dart';
import 'package:prueba_app/screens/page1.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        fontFamily: "Poppins",
        visualDensity: VisualDensity.adaptivePlatformDensity),
    debugShowCheckedModeBanner: false,
    initialRoute: 'HOME',
    routes: {'HOME': (_) => Home()},
  ));
}

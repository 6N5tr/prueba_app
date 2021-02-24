import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:prueba_app/models/constants.dart';
import 'package:prueba_app/screens/page1.dart';
import 'package:prueba_app/screens/page2.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List<Widget> _children = [Page1(), Page2()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 50.0,
            backgroundColor: Colors.blueAccent,
            color: Colors.white24,
            buttonBackgroundColor: Colors.blueAccent,
            items: <Widget>[
              Text(
                "Personajes",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              Text(
                "Episodios",
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
            index: page,
            onTap: (index) {
              //Handle button tap
              setState(() {
                page = index;
              });
            },
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.black12),
              ),
              _children[page],
            ],
          )),
    );
  }
}

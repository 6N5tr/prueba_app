import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:prueba_app/classes/actores.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_app/screens/page2.dart';

class Page1 extends StatefulWidget {
  Page1({Key key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Future<List<Episodios>> futureActores;
  Future<List<Episodios>> fetchActores() async {
    final response =
        await http.get('https://rickandmortyapi.com/api/character');

    List<Episodios> actores = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData["results"]) {
        actores.add(Episodios(
            name: item["name"], image: item["image"], status: item["status"]));
      }
      return actores;
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    futureActores = fetchActores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => {},
              );
            },
          ),
          title: Text("Personajes"),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.more_vert),
              onPressed: () => {},
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: futureActores,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  children: _lista(snapshot.data),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

List<Widget> _lista(List<Episodios> data) {
  List<Widget> actores = [];

  for (var actor in data) {
    actores.add(Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.black12,
        elevation: 10,
        shadowColor: Colors.white70,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        actor.image,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Nombre: ",
                          style: TextStyle(color: Colors.lightBlueAccent),
                        ),
                        Text(
                          actor.name,
                          style: TextStyle(color: Colors.lightGreenAccent),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Status: ",
                          style: TextStyle(color: Colors.lightBlueAccent),
                        ),
                        Text(
                          actor.status,
                          style: TextStyle(color: Colors.lightGreenAccent),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ])));
  }
  return actores;
}

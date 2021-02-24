import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba_app/classes/episodios.dart';
import 'package:http/http.dart' as http;

class Page2 extends StatefulWidget {
  Page2({Key key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Future<List<Episodios>> futureEpisodios;
  Future<List<Episodios>> fetchEpisodios() async {
    final response = await http.get('https://rickandmortyapi.com/api/episode');

    List<Episodios> episodios = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData["results"]) {
        episodios.add(Episodios(
            name: item["name"],
            date: item["air_date"],
            episodio: item["episode"]));
      }
      return episodios;
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    futureEpisodios = fetchEpisodios();
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
          title: Text("Episodios"),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.more_vert),
              onPressed: () => {},
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: futureEpisodios,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  children: _lista(snapshot.data),
                );
                //return Text(snapshot.data.name.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

List<Widget> _lista(List<Episodios> data) {
  List<Widget> episodios = [];

  for (var episodio in data) {
    episodios.add(Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.black12,
        elevation: 10,
        shadowColor: Colors.white70,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          Expanded(
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(episodio.name,
                              style: TextStyle(color: Colors.black45),
                              overflow: TextOverflow.clip),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text("Fecha: ",
                              style: TextStyle(color: Colors.lightBlueAccent),
                              overflow: TextOverflow.clip),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(episodio.date,
                              style: TextStyle(color: Colors.lightGreenAccent),
                              overflow: TextOverflow.clip),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text("Episodio: ",
                              style: TextStyle(color: Colors.lightBlueAccent),
                              overflow: TextOverflow.clip),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(episodio.episodio,
                              style: TextStyle(color: Colors.lightGreenAccent),
                              overflow: TextOverflow.clip),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
  return episodios;
}

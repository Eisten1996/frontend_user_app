import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  //final String username;{this.username}
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  List recData;

  getRecaudaciones() async {
    http.Response response = await http.get(
        'https://sigapdev2-consultarecibos-back.herokuapp.com/recaudaciones/alumno/concepto/listar_codigos/ELIZALDE');
    debugPrint(response.body);
    data = json.decode(response.body);
    // print(data[0]['ape_paterno']);
    data = jsonDecode(response.body);
    // print(data);
    setState(() {
      recData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getRecaudaciones();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Programas'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
        itemCount: recData == null ? 0 : recData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Text("$index"),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${recData[index]["nombre_programa"]}",
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${recData[index]["cod_alumno"]}",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

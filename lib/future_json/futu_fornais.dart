import 'package:flutter/material.dart';
import 'package:fornite_flutter/pages/page_muestra.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<dynamic> _obtenerDatos() async{
    http.Response data = await http.get("https://fortnite-api.theapinetwork.com/store/get");
    Map<String, dynamic> jsonData = json.decode(data.body);

    var opciones = jsonData["data"];

    List<User> nom = [];

    for (var i in opciones) {
      User user = User(i["item"]["name"],i["item"]["description"],i["item"]["images"]["icon"]);

      nom.add(user);
    }
    return nom;
    //print(opciones[2]["item"]["name"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("skin fornais"),
      ),
      body: FutureBuilder(
        future: _obtenerDatos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("no hay datos compa"),
              ),
            );
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                var jiji = snapshot.data[index].description == null ? "no tiene descripcion": snapshot.data[index].description;
                return ListTile(
                  leading: CircleAvatar(
                    //child: Text("${index+1}"),
                    backgroundImage: NetworkImage(snapshot.data[index].imagen),
                  ),
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(jiji),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => detallePage(snapshot.data[index])
                    ));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class User{
  final String name;
  final String description;
  final String imagen;

  User(this.name,this.description,this.imagen);

}


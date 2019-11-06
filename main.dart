import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
  MaterialApp(
    home: Splashed(),
  )
);

class Splashed extends StatefulWidget {
  @override
  _SplashedState createState() => _SplashedState();
}

class _SplashedState extends State<Splashed> {

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MyApp())
    );
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("스플레쉬"),
      ),
    );
  }
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future getUrl() async{
    String url = "";
    var res = await http.Client().get(url);
    return parsed(res.body);
  }

  parsed(resBody){
    var dats = json.decode(resBody);
    return dats.map((e)=>e).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "초단타 Flutter",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: getUrl(),
          builder: (context, snap){
            if(!snap.hasData){
              return CircularProgressIndicator();
            }
            return Text(
              snap.data.toString(),
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 34.0
              ),
            );
          },
        )
      ),
    );
  }
}

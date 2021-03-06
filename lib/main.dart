import 'dart:convert';
import 'dart:developer';

import 'package:amazone_clone/models/all_users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<AllUsers> allUsers = [];

  getAllUsers() async {
    print("get called");
    setState(() {
      allUsers = [];
    });
    // String url = "http://127.0.0.1:3000/api/get_all_users"; for ios
    // String url = "http://10.0.2.2:8080/api/get_all_users"; // for android emulator
    String url = "http://10.0.2.2:8080/api/get_all_users";
    // Uri.http("locahost:3000", "/api/get_all_users");

    http.Response res =
        await http.get(Uri.parse(url), headers: {"Accept": "json/application"});
    print(res.body.toString());
    if (res.statusCode == 200) {
      AllUsersModel data = AllUsersModel.fromJson(json.decode(res.body));
      setState(() {
        allUsers = data.allUsers!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(
            "Flutter Developers",
            style: TextStyle(
                fontSize: 35, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allUsers.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        "${i + 1}. " + allUsers[i].name!,
                        style: TextStyle(fontSize: 30, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getAllUsers,
        child: Icon(Icons.refresh),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

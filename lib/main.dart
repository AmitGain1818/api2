import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map? mapResponse;
  Map? mapJsonData;
  List? listResponse;

  fetchData() async {
    http.Response response;

    response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=2'),
    );
    if (response.statusCode == 200) {
      mapResponse = jsonDecode(response.body);
      setState(() {
        mapJsonData = mapResponse;
        listResponse = mapJsonData?['data'] as List;
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('List View map'),
          ),
          drawer: Drawer(
            backgroundColor: Colors.green[100],
            elevation: 6.0,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.greenAccent,
                          Colors.lightGreen,
                        ]),
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.lightGreen,
                  ),
                  title: Text('person'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.lightGreen,
                  ),
                  title: Text('person'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.login,
                    color: Colors.lightGreen,
                  ),
                  title: Text('person'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.lightGreen,
                  ),
                  title: Text('person'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.lightGreen,
                  ),
                  title: Text('person'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          backgroundColor: Colors.green[50],
          body: ListView.builder(
              itemCount: listResponse?.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Image.network(
                            listResponse?[index]['avatar'],
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(listResponse![index]['id'].toString()),
                      Text(listResponse?[index]['first_name']),
                      Text(listResponse?[index]['last_name']),
                      Text(listResponse?[index]['email']),
                    ],
                  ),
                );
              })),
    );
  }
}

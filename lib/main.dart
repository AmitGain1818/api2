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
  var stringData;
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
          backgroundColor: Colors.green[50],
          body: ListView.builder(
              itemCount: listResponse?.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(listResponse?[index]['avatar']),
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

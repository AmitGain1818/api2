import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: const Text('List View API'),
          ),
          drawer: Drawer(
            backgroundColor: Colors.green[100],
            elevation: 6.0,
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.greenAccent,
                        Colors.lightGreen,
                      ],
                    ),
                  ),
                  child: Text(
                    'Member Area',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.lightGreen,
                  ),
                  title: const Text('Person'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.inbox,
                    color: Colors.lightGreen,
                  ),
                  title: const Text('Contact'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.login,
                    color: Colors.lightGreen,
                  ),
                  title: const Text('Login'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.lightGreen,
                  ),
                  title: const Text('Logout'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.lightGreen,
                  ),
                  title: const Text('Setings'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          body: ListView.builder(
              itemCount: listResponse?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.network(
                        listResponse?[index]['avatar'],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text('ID: ${listResponse![index]['id'].toString()}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          listResponse?[index]['first_name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          listResponse?[index]['last_name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text('Email: ${listResponse?[index]['email']}'),
                  ],
                );
              })),
    );
  }
}

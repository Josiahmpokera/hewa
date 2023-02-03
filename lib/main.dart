import 'package:flutter/material.dart';
import 'package:hewa/screens/home.dart';
import 'package:hewa/screens/search.dart';
import 'package:http/http.dart' as http;
import './model.dart';
import 'dart:async';
import 'dart:convert';

final url =
    ("https://api.openweathermap.org/data/2.5/weather?lat=-6.8160837&lon=39.2803583&appid=acece3914bff7be493968d98f6a4420e");

// make the Request here
Future<Weather> fetchWeather() async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("Server did return response of Data");
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to Load Weather");
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Signika'),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  void _onSelectIcon(int index) {
    setState(() {
      _counter = index;
    });
  }

  // Make the Pages here

  static const List<Widget> _pages = <Widget>[
    Home(),
    Search(),
    Text("Page Three"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onSelectIcon,
        currentIndex: _counter,
        backgroundColor: Colors.blue[900],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedItemColor: Colors.amber[600],
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "History", icon: Icon(Icons.reply)),
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF1E60B9),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hewa"),
            const SizedBox(
              width: 4,
            ),
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ],
        ),
      ),
      body: _pages.elementAt(
          _counter), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

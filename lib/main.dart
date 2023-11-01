import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taza_khabar/widgets/business.dart';
import 'package:taza_khabar/widgets/health.dart';
import 'package:taza_khabar/widgets/sports.dart';
import 'package:taza_khabar/widgets/technology.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  int _currentIndex = 0;
  @override
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<String> labels = [
    "Business-Top Headlines",
    "Sports-Top Headlines",
    "Health-Top Headlines",
    "Technology-Top Headlines"
  ];
  static const List<Widget> _widgetOptions = <Widget>[
    BusinessScreen(),
    SportsScreen(),
    HealthScreen(),
    TechnologyScreen()
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: labels
            .elementAt(_currentIndex)
            .text
            .textStyle(TextStyle(fontSize: 18, color: Colors.black))
            .make(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.business_center), label: "Business"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports), label: "Sports"),
          BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety), label: "Health"),
          BottomNavigationBarItem(
              icon: Icon(Icons.laptop_mac_rounded), label: "Technology")
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}

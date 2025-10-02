import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/Ui/home_screen.dart';
import 'package:weatherapp/Ui/location_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? isselected = await prefs.getString('Selectedcity');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(isselected: isselected));
}

class MyApp extends StatelessWidget {
  String? isselected;
  MyApp({super.key, this.isselected});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isselected == null ? LocationScreen() : HomeScreen(),
    );
  }
}

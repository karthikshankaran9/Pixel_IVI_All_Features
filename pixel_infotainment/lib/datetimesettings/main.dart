import 'package:flutter/material.dart';
import 'package:pixel_infotainment/datetimesettings/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'date time',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home : HomePage(),
    );
  }
}

//need to change name convention for assets 

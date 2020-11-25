import 'package:bus_android/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyApp');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: HomePage(),
      ),
    );
  }
}

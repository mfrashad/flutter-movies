import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      //home: Home(),
      routes: {
        '/' : (context) => Home(),
        '/detail': (context) => Detail()
      }
    );
  }
}


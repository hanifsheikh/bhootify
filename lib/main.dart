import 'package:flutter/material.dart';
import 'package:bhootify/screens/home.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFF3EBACE),
          scaffoldBackgroundColor: const Color(0xFFF3F5F7)),
      home: const HomeScreen(),
    );
  }
}

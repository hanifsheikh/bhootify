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
      title: 'Bhootify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFFFA7F16),
          scaffoldBackgroundColor: const Color.fromARGB(255, 42, 42, 42)),
      home: const HomeScreen(),
    );
  }
}

import 'package:bhootify/providers/music_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:bhootify/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<MusicPlayerProvider>(
      child: const MyApp(), create: (_) => MusicPlayerProvider()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
        primaryColor: const Color(0xFFFA7F16),
        scaffoldBackgroundColor: const Color.fromARGB(255, 42, 42, 42));
    return MaterialApp(
      title: 'Bhootify',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme:
            theme.colorScheme.copyWith(secondary: const Color(0xFFFA7F16)),
      ),
      home: const HomeScreen(),
    );
  }
}

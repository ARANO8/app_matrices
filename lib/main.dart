import 'package:app_matrices/src/inversa.dart';
import 'package:app_matrices/src/transformacion.dart';
import 'package:app_matrices/src/transpuesta.dart';
import 'package:flutter/material.dart';
import 'package:app_matrices/src/homescreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(useMaterial3: true),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const HomeScreen(),
        "/inversa": (context) => const Inversa(),
        "/transpuesta": (context) => const Transpuesta(),
        "/transformacion": (context) => const Transformacion(),
      },
    );
  }
}

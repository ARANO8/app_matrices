import 'package:app_matrices/src/inversa.dart';
import 'package:app_matrices/src/transformacion.dart';
import 'package:app_matrices/src/transpuesta.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> list = [
  {
    "Titulo": "Transpuesta",
    "color": Colors.cyan.shade900,
  },
  {
    "Titulo": "Transformacion",
    "color": Colors.cyan.shade900,
  },
  {
    "Titulo": "Inversa",
    "color": Colors.cyan.shade900,
  },
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alan Israel Arnez Flores',
          style: TextStyle(
            color: Color.fromARGB(255, 19, 19, 19),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          margin: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Navegar a diferentes pantallas según el índice
                  switch (index) {
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Transpuesta()),
                      );
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Transformacion()),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Inversa()),
                      );
                      break;
                    default:
                      break;
                  }
                },
                child: Card(
                  color: list[index]['color'],
                  child: ListTile(
                    title: Text(
                      list[index]['Titulo'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

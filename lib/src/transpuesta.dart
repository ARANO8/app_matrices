import 'package:app_matrices/src/homescreen.dart';
import 'package:flutter/material.dart';

class Transpuesta extends StatefulWidget {
  const Transpuesta({super.key});

  @override
  State<Transpuesta> createState() => _TranspuestaState();
}

class _TranspuestaState extends State<Transpuesta> {
  TextEditingController matrixController = TextEditingController();
  List<List<int>> matrix = [];
  String m = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transpuesta',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 5,
              controller: matrixController,
              decoration: const InputDecoration(
                hintText: "Ingrese la matriz...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                m = value;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              processMatrix(m);
              calculateTranspose();
            },
            child: const Text('Calcular Transpuesta'),
          ),
          const SizedBox(
            height: 16,
          ),
          if (matrix.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Matriz transpuesta:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  for (int i = 0; i < matrix[0].length; i++)
                    Text(
                      matrix.map((row) => row[i].toString()).join('\t'),
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void processMatrix(String input) {
    try {
      List<List<int>> result = [];

      List<String> rows = input.trim().split('\n');
      for (String row in rows) {
        List<int> values = row
            .trim()
            .split('\t')
            .map((value) => int.tryParse(value) ?? 0)
            .toList();
        result.add(values);
      }

      setState(() {
        matrix = result;
      });
    } catch (e) {
      // Error al analizar números
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Solo se admiten valores enteros en la matriz.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void calculateTranspose() {
    List<List<int>> transpose = [];

    if (matrix.isNotEmpty) {
      for (int i = 0; i < matrix[0].length; i++) {
        List<int> column = matrix.map((row) => row[i]).toList();
        transpose.add(column);
      }
    }

    setState(() {
      matrix = transpose;
    });
  }
}

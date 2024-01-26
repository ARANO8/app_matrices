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
              maxLines: 4,
              controller: matrixController,
              decoration: const InputDecoration(
                hintText: "Ingrese la matriz...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                processMatrix(value);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //processMatrix(m);
              calculateTranspose(matrix);
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
      List<List<int>> matriz = procesarEntrada(input);
      setState(() {
        matrix = matriz;
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

  List<List<int>> procesarEntrada(String? entrada) {
    List<List<int>> matriz = [];

    if (entrada != null) {
      List<String> filas = entrada.split('\n');
      for (String fila in filas) {
        List<int> valoresFila =
            fila.split('\t').map((e) => int.parse(e)).toList();
        matriz.add(valoresFila);
      }
    }

    return matriz;
  }

  void calculateTranspose(List<List<int>> matriz) {
    int filas = matriz.length;
    int columnas = matriz[0].length;

    List<List<int>> transpose =
        List.generate(columnas, (index) => List.filled(filas, 0));
    for (int i = 0; i < matriz.length; i++) {
      for (int j = 0; j < matriz[i].length; j++) {
        transpose[j][i] = matriz[i][j];
      }
    }
    setState(() {
      matrix = transpose;
    });
  }
}

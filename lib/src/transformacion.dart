import 'package:app_matrices/src/homescreen.dart';
import 'package:flutter/material.dart';

class Transformacion extends StatefulWidget {
  const Transformacion({super.key});

  @override
  State<Transformacion> createState() => _TransformacionState();
}

class _TransformacionState extends State<Transformacion> {
  TextEditingController matrixController = TextEditingController();
  List<List<int>> matrix = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transformacion'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Esta es una calculadora para hallar la transformacion lineal de un vector en R3 a un vector en R2 donde la transformacion es x + y, y + z',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  maxLines: 5,
                  controller: matrixController,
                  decoration: const InputDecoration(
                    hintText: "Ingrese la matriz...",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    processMatrix(value);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    calculateLinearTransformation();
                  },
                  child: const Text('Calcular Transformacion'),
                ),
              ],
            ),
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
                    'Resultado de la Transformacion:',
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
        List<int> values = row.trim().split('\t').map((value) {
          try {
            // Verificar si el valor es numérico
            num numericValue = num.parse(value);
            return numericValue.toInt();
          } catch (e) {
            // Si no es numérico, asignar 0
            return 0;
          }
        }).toList();

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

  void calculateLinearTransformation() {
    List<List<int>> transformedMatrix = [];

    if (matrix.isNotEmpty && matrix[0].length == 3) {
      for (int i = 0; i < matrix.length; i++) {
        int x = matrix[i][0];
        int y = matrix[i][1];
        int z = matrix[i][2];

        // Aplicar la transformación lineal
        int resultX = x + y;
        int resultY = y + z;

        transformedMatrix.add([resultX, resultY]);
      }
    }

    setState(() {
      matrix = transformedMatrix;
    });
  }
  

  void showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

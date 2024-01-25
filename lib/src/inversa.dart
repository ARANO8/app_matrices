import 'package:app_matrices/src/homescreen.dart';
import 'package:flutter/material.dart';

class Inversa extends StatefulWidget {
  const Inversa({super.key});

  @override
  State<Inversa> createState() => _InversaState();
}

class _InversaState extends State<Inversa> {
  TextEditingController matrixController = TextEditingController();
  List<List<double>> matrix = [];
  String m = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inversa'),
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
              calculateInverse();
            },
            child: const Text('Calcular Inversa'),
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
                    'Matriz Inversa:',
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
    List<List<double>> result = [];

    List<String> rows = input.trim().split('\n');
    int rowCount = rows.length;
    int columnCount = 0;

    for (String row in rows) {
      List<double> values = row
          .trim()
          .split('\t')
          .map((value) => double.tryParse(value) ?? 0.0)
          .toList();

      // Verificar si todas las filas tienen la misma cantidad de columnas
      if (columnCount == 0) {
        columnCount = values.length;
      } else if (columnCount != values.length) {
        _showAlert("Error", "La matriz no es cuadrada.");
        return;
      }

      result.add(values);
    }
    // Verificar si la matriz es cuadrada
    if (rowCount != columnCount) {
      _showAlert("Error", "La matriz no es cuadrada.");
      return;
    }

    // Verificar si el determinante es cero
    double determinant = _calculateDeterminant(result);
    if (determinant == 0) {
      _showAlert("Error",
          "La matriz no tiene inversa debido a que su determinante es cero.");
      return;
    }
    setState(() {
      matrix = result;
    });
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
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

  void calculateInverse() {
    double determinant = _calculateDeterminant(matrix);

    List<List<double>> adjugate = _calculateAdjugate(matrix);
    List<List<double>> inverse = _scalarMultiply(adjugate, 1 / determinant);

    setState(() {
      matrix = inverse;
    });
  }

  double _calculateDeterminant(List<List<double>> mat) {
    // Lógica para calcular el determinante (puede ser una implementación recursiva)

    return mat[0][0] * mat[1][1] - mat[0][1] * mat[1][0];
  }

  List<List<double>> _calculateAdjugate(List<List<double>> mat) {
    // Lógica para calcular la matriz adjunta

    return [
      [mat[1][1], -mat[0][1]],
      [-mat[1][0], mat[0][0]],
    ];
  }

  List<List<double>> _scalarMultiply(List<List<double>> mat, double scalar) {
    // Lógica para multiplicar una matriz por un escalar
    return mat
        .map((row) => row.map((value) => value * scalar).toList())
        .toList();
  }
}

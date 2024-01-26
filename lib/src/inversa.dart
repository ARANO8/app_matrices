import 'dart:math';

import 'package:app_matrices/src/homescreen.dart';
import 'package:flutter/material.dart';

class Inversa extends StatefulWidget {
  const Inversa({super.key});

  @override
  State<Inversa> createState() => _InversaState();
}

class _InversaState extends State<Inversa> {
  TextEditingController matrixController = TextEditingController();
  List<List<int>> matrix = [];
  List<List<double>> inv = [];
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
              calculateInverse(matrix);
            },
            child: const Text('Calcular Inversa'),
          ),
          const SizedBox(
            height: 16,
          ),
          if (inv.isNotEmpty)
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
                  for (int i = 0; i < inv[0].length; i++)
                    Text(
                      inv.map((row) => row[i].toString()).join('\t'),
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
    setState(() {
      matrix = procesarEntrada(input);
    });
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

  //void _showAlert(String title, String message) {
  //  showDialog(
  //    context: context,
  //    builder: (context) => AlertDialog(
  //      title: Text(title),
  //      content: Text(message),
  //      actions: [
  //        TextButton(
  //          onPressed: () {
  //            Navigator.pushAndRemoveUntil(
  //              context,
  //              MaterialPageRoute(builder: (context) => HomeScreen()),
  //              (route) => false,
  //            );
  //          },
  //          child: const Text("OK"),
  //        ),
  //      ],
  //    ),
  //  );
  //}

  void calculateInverse(List<List<int>> matrix) {
    int filas = matrix.length;
    int columnas = matrix[0].length;

    List<List<double>> inverse =
        List.generate(columnas, (index) => List.filled(filas, 0));
    int num = _calculateDeterminant(matrix);
    List<List<int>> adj = adjunta(matrix);

    for (int i = 0; i < adj.length; i++) {
      for (int j = 0; j < adj[i].length; j++) {
        inverse[i][j] = num / adj[i][j];
      }
    }

    setState(() {
      inv = inverse;
    });
  }

  int _calculateDeterminant(List<List<int>> matrix) {
    int size = matrix.length;

    if (size == 1) {
      return matrix[0][0];
    }

    if (size == 2) {
      return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
    }

    int determinant = 0;

    for (int i = 0; i < size; i++) {
      int sign = (i % 2 == 0) ? 1 : -1;
      int cofactor = sign *
          matrix[0][i] *
          _calculateDeterminant(getSubmatrix(matrix, 0, i));
      determinant += cofactor;
    }

    return determinant;
  }

  List<List<int>> getSubmatrix(List<List<int>> matrix, int row, int col) {
    int size = matrix.length;
    List<List<int>> submatrix =
        List.generate(size - 1, (i) => List.filled(size - 1, 0));
    int f = 0;
    for (int i = 0; i < matrix.length; i++) {
      int c = 0;
      if (i != row) {
        for (int j = 0; j < matrix[i].length; j++) {
          if (j != col) {
            submatrix[f][c] = matrix[i][j];
            c++;
          }
        }

        f++;
      }
    }
    return submatrix;
  }

  List<List<int>> adjunta(List<List<int>> matrix) {
    int filas = matrix.length;
    int columnas = matrix[0].length;

    List<List<int>> adjunta =
        List.generate(columnas, (index) => List.filled(filas, 0));
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        int sign = pow(-1, i + j).toInt();
        adjunta[i][j] =
            sign * _calculateDeterminant(getSubmatrix(matrix, i, j));
      }
    }
    return calculateTranspose(adjunta);
  }

  List<List<int>> calculateTranspose(List<List<int>> matriz) {
    int filas = matriz.length;
    int columnas = matriz[0].length;

    List<List<int>> transpose =
        List.generate(columnas, (index) => List.filled(filas, 0));
    for (int i = 0; i < matriz.length; i++) {
      for (int j = 0; j < matriz[i].length; j++) {
        transpose[j][i] = matriz[i][j];
      }
    }
    return transpose;
  }
}

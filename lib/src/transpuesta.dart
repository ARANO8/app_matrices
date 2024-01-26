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
  String m = '''''';
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
                m = value;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // processMatrix(m);
              calculateTranspose(procesarEntrada(m));
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
                    'matriz transpuesta:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  for (int i = 0; i < matrix.length; i++)
                    Text(
                      matrix[i].join('\t'),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<List<int>> procesarEntrada(String? entrada) {
    List<List<int>> mat = [];
    if (entrada != null) {
      List<String> filas = entrada.split('\n');
      for (String fila in filas) {
        List<int> valoresFila =
            fila.split(' ').map((e) => int.parse(e)).toList();
        mat.add(valoresFila);
      }
    }
    return mat;
  }

  void imprimirmatrix(List<List<int>> matrix) {
    for (int i = 0; i < matrix.length; i++) {
      print(matrix[i].join(' '));
    }
  }

  void calculateTranspose(List<List<int>> matrix) {
    int filas = matrix.length;
    int columnas = matrix[0].length;

    List<List<int>> transpose =
        List.generate(columnas, (index) => List.filled(filas, 0));

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        transpose[j][i] = matrix[i][j];
      }
    }
    print('calculo de transpuesta?');
    setState(() {
      matrix = transpose;
    });
  }
}

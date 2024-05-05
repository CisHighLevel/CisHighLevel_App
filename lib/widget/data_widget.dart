import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba_flutter_2/widget/pallete.dart';

class DataWidget extends StatelessWidget {
  final String text;
  final double progress;


  DataWidget({Key? key, required this.progress, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percentge= progress*100;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Pallete.text,
            ),
          ),
          const SizedBox(height: 20),
Container(
  height: 500, // Ajusta la altura según tus necesidades
  width: 150, // Ajusta el ancho según tus necesidades
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    border:Border.all(color: Pallete.text, width: 2.0),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: RotatedBox(
      quarterTurns: -1,
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Pallete.secondary, // Establecer transparente para que no oculte el borde gris
        valueColor: AlwaysStoppedAnimation<Color>(Pallete.accent),
      ),
    ),
  ),
),
SizedBox(height: 10),
          Text(
            "${percentge.toStringAsFixed(0)} %",
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Pallete.text,
            ),
          ),
        ],
      ),
    );
  }
}

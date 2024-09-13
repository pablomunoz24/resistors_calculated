import 'package:flutter/material.dart';

class ResistorCal extends StatefulWidget {
  const ResistorCal({super.key});

  @override
  State<ResistorCal> createState() => _ResistorCalState();
}

class _ResistorCalState extends State<ResistorCal> {
  final  Map<String, int> codigoColoresResistencia = {
    'Negro': 0,
    'Marrón': 1,
    'Rojo': 2,
    'Naranja': 3,
    'Amarillo': 4,
    'Verde': 5,
    'Azul': 6,
    'Violeta': 7,
    'Gris': 8,
    'Blanco': 9,
  };
  //Tolerancias
  final  Map<String, double> toleranciaColor = {
    'Plateado':0.10,
    'Dorado':0.05,
    'Rojo': 0.02,
    'Marron':0.01,
  };
  //Lista opciones de bandas
  var items = ['Cuatro Bandas','Cinco Bandas', 'Seis Bandas'];
  Widget build(BuildContext context) {
    return const Placeholder(

    );
  }
}

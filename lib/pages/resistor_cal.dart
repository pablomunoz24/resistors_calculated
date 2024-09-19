import 'package:flutter/material.dart';


class ResistorCal extends StatefulWidget {
  @override
  State<ResistorCal> createState() => _ResistorCalState();
}

class _ResistorCalState extends State<ResistorCal> {
  // Inicialización de menús
  String selectedBandas = 'Cuatro Bandas';
  String selectedColor1 = 'Negro';
  String selectedColor2 = 'Negro';
  String selectedColor3 = 'Negro';
  String selectedColorM = 'Negro';
  String selectedColor4 = 'Negro';

  String selectedTolerancia = 'Plateado';

  // Mapas para los colores
  final Map<String, double> codigoColoresResistencia = {
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
  final Map<String, double> tcrColoresResistencia = {
    'Negro': 250,      // ppm/°C
    'Marrón': 100,     // ppm/°C
    'Rojo': 50,        // ppm/°C
    'Naranja': 15,     // ppm/°C
    'Amarillo': 25,    // ppm/°C
    'Verde': 20,       // ppm/°C
    'Azul': 10,        // ppm/°C
    'Violeta': 5,      // ppm/°C
    'Gris': 1,         // ppm/°C
    'Blanco': 0.5,     // ppm/°C
  };

  final Map<String, double> multiplicadorColoresResistencia = {
    'Negro': 1,
    'Marrón': 10,
    'Rojo': 100,
    'Naranja': 1000,
    'Amarillo': 10000,
    'Verde': 100000,
    'Azul': 1000000,
    'Violeta': 10000000,
    'Gris': 100000000,
    'Blanco': 1000000000,
    'Oro': 0.1,
    'Plata': 0.01,
  };

  final Map<String, double> toleranciaColor = {
    'Plateado': 10,
    'Dorado': 5,
    'Rojo': 2,
    'Marron': 1,
  };

  // Listas para los menús desplegables
  var itemsColor = ['Negro', 'Marrón', 'Rojo', 'Naranja', 'Amarillo', 'Verde', 'Azul', 'Violeta', 'Gris', 'Blanco'];
  var itemsMcolor=  ['Negro', 'Marrón', 'Rojo', 'Naranja', 'Amarillo', 'Verde', 'Azul', 'Violeta', 'Gris', 'Blanco','Plata','Dorado'];
  var itemsTolerancia = ['Plateado', 'Dorado', 'Rojo', 'Marron'];
  var itemsBandas = ['Cuatro Bandas', 'Cinco Bandas', 'Seis Bandas'];

  // Control de visibilidad
  bool mostrarQuintaBanda = false;
  bool mostrarSextaBanda = false;

  double valor_resis= 0.0;
  double valor_tole= 0.0;
  double valor_TCR= 0.0;

  void _calcresit(){
    setState(() {
      if (selectedBandas == 'Cuatro Bandas'){
        valor_resis= (10*codigoColoresResistencia[selectedColor1]!+codigoColoresResistencia[selectedColor2]!);
      }
      else if (selectedBandas== 'Cinco Bandas') {
        valor_resis = (100 * codigoColoresResistencia[selectedColor1]! +
            10 * codigoColoresResistencia[selectedColor2]! +
            codigoColoresResistencia[selectedColor3]!);
      }
        else if(selectedBandas== 'Seis Bandas'){
        valor_resis = (100 * codigoColoresResistencia[selectedColor1]! +
            10 * codigoColoresResistencia[selectedColor2]! +
            codigoColoresResistencia[selectedColor3]!);
          valor_TCR = tcrColoresResistencia[selectedColor4]!;
      }
      valor_tole = toleranciaColor[selectedTolerancia]!;

      valor_resis=valor_resis*multiplicadorColoresResistencia[selectedColorM]!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resistor Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              // Selección del número de bandas
              DropdownButtonFormField(
                value: selectedBandas,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  labelText: 'Seleccione el número de bandas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: itemsBandas.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBandas = newValue!;
                    // Controlar la visibilidad de las bandas adicionales
                    if (selectedBandas == 'Cuatro Bandas') {
                      mostrarQuintaBanda = false;
                      mostrarSextaBanda = false;
                    } else if (selectedBandas == 'Cinco Bandas') {
                      mostrarQuintaBanda = true;
                      mostrarSextaBanda = false;
                    } else if (selectedBandas == 'Seis Bandas') {
                      mostrarQuintaBanda = true;
                      mostrarSextaBanda = true;
                    }
                  });

                },

              ),

              const SizedBox(height: 16),

              // Selección de colores
              DropdownButtonFormField(
                value: 'Negro',
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  labelText: 'Seleccione el primer color',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: itemsColor.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedColor1 = newValue!;
                  });

                },
              ),

              const SizedBox(height: 16),

              // Segundo color
              DropdownButtonFormField(
                value: 'Negro',
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  labelText: 'Seleccione el segundo color',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: itemsColor.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedColor2 = newValue!;
                  });
                  },
              ),

              const SizedBox(height: 16),
              if (mostrarQuintaBanda)
                DropdownButtonFormField(
                  value: selectedColor3,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                    labelText: 'Seleccione el tercer color',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: itemsColor.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedColor3= newValue!;
                    });
                  },
                ),

              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: 'Negro',
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  labelText: 'Seleccione el multiplicador',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: itemsMcolor.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedColorM = newValue!;
                  });
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: selectedTolerancia,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  labelText: 'Seleccione la tolerancia ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: itemsTolerancia.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTolerancia = newValue!;
                  });

                },
              ),

              const SizedBox(height: 16),

              // Mostrar la sexta banda si corresponde
              if (mostrarSextaBanda)
                DropdownButtonFormField(
                  value: selectedColor4,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                    labelText: 'Seleccione el color para la sexta banda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: itemsColor.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedColor4 = newValue!;
                    });
                  },
                ),

              ElevatedButton(
                onPressed: _calcresit,
                child: const Text("Calcular Resistencia"),
              ),
              const SizedBox(height: 16.0),
              Text("Resistencia: $valor_resis  $valor_tole%  $valor_TCR ppm/°C "),
            ],
          ),
        ),
      ),
    );
  }
}

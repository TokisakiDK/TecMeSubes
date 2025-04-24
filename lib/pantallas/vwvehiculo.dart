import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbase.dart';
import 'package:tec_me_subes/pantallas/conductor/vwInicioConductor.dart';

class VwVehiculo extends StatefulWidget {
  const VwVehiculo({super.key});

  @override
  State<VwVehiculo> createState() => _VwVehiculoState();
}

class _VwVehiculoState extends State<VwVehiculo> {
  String? _tipoVehiculo;
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _colorController = TextEditingController();
  final _placasController = TextEditingController();
  int? _capacidad;
  final List<int> _capacidadesCarro = [2, 3, 4, 5, 6, 7];

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _colorController.dispose();
    _placasController.dispose();
    super.dispose();
  }

  void _registrarVehiculo() {
    if (_tipoVehiculo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Seleccione un tipo de vehículo')),
      );
      return;
    }

    if (_marcaController.text.isEmpty ||
        _modeloController.text.isEmpty ||
        _colorController.text.isEmpty ||
        _placasController.text.isEmpty ||
        _capacidad == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete todos los campos')),
      );
      return;
    }

    // Guardar datos del vehículo (simulado)
    final vehiculoData = {
      'tipo': _tipoVehiculo,
      'marca': _marcaController.text,
      'modelo': _modeloController.text,
      'color': _colorController.text,
      'placas': _placasController.text,
      'capacidad': _capacidad,
    };

    // Navegar a pantalla de inicio del conductor
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const VWInicioConductor(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vehículo registrado exitosamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VwBase(
      titulo: 'Registrar Vehículo',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Selecciona el tipo de vehículo',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _tipoVehiculo = 'carro';
                        _capacidad = null;
                      });
                    },
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: _tipoVehiculo == 'carro' 
                            ? Colors.blue[600] 
                            : Colors.blue.withValues(alpha:0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.directions_car, 
                              size: 40, color: Colors.white),
                          const SizedBox(height: 10),
                          const Text('Automóvil',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _tipoVehiculo = 'moto';
                        _capacidad = 1;
                      });
                    },
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: _tipoVehiculo == 'moto' 
                            ? Colors.black 
                            : Colors.grey[600],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.motorcycle, 
                              size: 40, color: Colors.white),
                          const SizedBox(height: 10),
                          const Text('Motocicleta',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            if (_tipoVehiculo != null) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _marcaController,
                      decoration: const InputDecoration(
                        labelText: 'Marca',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    TextFormField(
                      controller: _modeloController,
                      decoration: const InputDecoration(
                        labelText: 'Modelo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    TextFormField(
                      controller: _colorController,
                      decoration: const InputDecoration(
                        labelText: 'Color',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    TextFormField(
                      controller: _placasController,
                      decoration: const InputDecoration(
                        labelText: 'Placas',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    if (_tipoVehiculo == 'carro')
                      DropdownButtonFormField<int>(
                        value: _capacidad,
                        decoration: const InputDecoration(
                          labelText: 'Capacidad (pasajeros)',
                          border: OutlineInputBorder(),
                        ),
                        items: _capacidadesCarro.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value persona${value > 1 ? 's' : ''}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _capacidad = value;
                          });
                        },
                      ),
                    
                    if (_tipoVehiculo == 'moto')
                      const Text(
                        'Capacidad: 1 persona',
                        style: TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _registrarVehiculo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'REGISTRAR VEHÍCULO',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tec_me_subes/bases/vwbaseviajes.dart';

class VWPedirViaje extends StatefulWidget {
  const VWPedirViaje({super.key});

  @override
  State<VWPedirViaje> createState() => _VWPedirViajeState();
}

class _VWPedirViajeState extends State<VWPedirViaje> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _origenController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  int _pasajeros = 1;

  static List<Map<String, dynamic>> viajesPedidos = [];

  @override
  void dispose() {
    _origenController.dispose();
    _destinoController.dispose();
    _horaController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _horaController.text = picked.format(context);
      });
    }
  }

  void _pedirViaje() {
    if (_formKey.currentState!.validate()) {
      final nuevoViaje = {
        'origen': _origenController.text,
        'destino': _destinoController.text,
        'hora': _horaController.text,
        'pasajeros': _pasajeros,
        'fecha': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      };

      setState(() {
        viajesPedidos.add(nuevoViaje);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Viaje solicitado correctamente')),
      );

      _origenController.clear();
      _destinoController.clear();
      _horaController.clear();
      setState(() {
        _pasajeros = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VWBaseViajes(
      tituloPantalla: 'Pedir Viaje',
      cuerpoPantalla: _buildBody(context),
      indiceInicial: 1,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () => Navigator.pushReplacementNamed(context, '/inicio-pasajero'),
            ),
          ),
          const SizedBox(height: 20),
          _buildFormularioViaje(context),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _pedirViaje,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Solicitar Viaje',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormularioViaje(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _origenController,
            decoration: InputDecoration(
              labelText: 'Origen del viaje',
              prefixIcon: const Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el origen';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _destinoController,
            decoration: InputDecoration(
              labelText: 'Destino del viaje',
              prefixIcon: const Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el destino';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _horaController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Hora de salida',
              prefixIcon: const Icon(Icons.access_time),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectTime(context),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor selecciona la hora';
              }
              return null;
            },
            onTap: () => _selectTime(context),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Número de pasajeros',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (_pasajeros > 1) {
                            setState(() => _pasajeros--);
                          }
                        },
                      ),
                      Text(
                        '$_pasajeros',
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() => _pasajeros++);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
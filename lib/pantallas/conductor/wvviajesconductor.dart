import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tec_me_subes/bases/vwbaseconductor.dart';

class VWViajesConductor extends StatefulWidget {
  const VWViajesConductor({super.key});

  @override
  State<VWViajesConductor> createState() => _VWViajesConductorState();
}

class _VWViajesConductorState extends State<VWViajesConductor> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _origenController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  int _pasajeros = 1;

  // Variables para el mapa
  final MapController _mapController = MapController();
  LatLng? _origenCoords;
  LatLng? _destinoCoords;
  List<LatLng> _ruta = [];
  bool _mostrandoRuta = false;

  // Lugares frecuentes para autocompletar
  final List<String> _lugaresFrecuentes = [
    'Instituto Tecnológico de Pachuca',
    'Plaza Galerías',
    'Fraccionamiento Los Tuzos',
    'Villas de Pachuca',
    'Centro Histórico',
    'Terminal de Autobuses',
    'Plaza Bella'
  ];

  @override
  void dispose() {
    _origenController.dispose();
    _destinoController.dispose();
    _horaController.dispose();
    _precioController.dispose();
    _mapController.dispose();
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

  void _calcularRuta() {
    if (_origenController.text.isEmpty || _destinoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa origen y destino primero')),
      );
      return;
    }

    // Simulación de coordenadas (en una app real usarías una API como Google Maps o OSRM)
    setState(() {
      _origenCoords = const LatLng(20.1234, -98.7654); // Coordenadas de ejemplo
      _destinoCoords = const LatLng(20.1256, -98.7698); // Coordenadas de ejemplo
      
      // Simulación de puntos intermedios para la ruta
      _ruta = [
        _origenCoords!,
        const LatLng(20.1240, -98.7665),
        const LatLng(20.1245, -98.7678),
        _destinoCoords!,
      ];
      
      _mostrandoRuta = true;
      
      // Ajustar el mapa para mostrar toda la ruta
      _mapController.fitBounds(
        LatLngBounds.fromPoints(_ruta),
        options: const FitBoundsOptions(
          padding: EdgeInsets.all(50),
        ),
      );
    });
  }

  void _crearViaje() {
    if (_formKey.currentState!.validate() && _mostrandoRuta) {
      // Aquí iría la lógica para guardar el viaje en tu backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Viaje creado exitosamente')),
      );
      
      // Limpiar formulario
      _origenController.clear();
      _destinoController.clear();
      _horaController.clear();
      _precioController.clear();
      setState(() {
        _pasajeros = 1;
        _mostrandoRuta = false;
        _ruta = [];
      });
    } else if (!_mostrandoRuta) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Calcula la ruta primero')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return VWBaseConductor(
      tituloPantalla: 'Crear Viaje',
      cuerpoPantalla: _buildBody(context),
      indiceInicial: 1,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Mapa para mostrar la ruta
            _buildMapa(),
            const SizedBox(height: 20),
            
            // Formulario para crear el viaje
            _buildFormularioViaje(),
            const SizedBox(height: 20),
            
            // Botones de acción
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildMapa() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: const LatLng(20.1245, -98.7675), // Centro de Pachuca
            zoom: 14.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            
            // Marcador de origen
            if (_origenCoords != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _origenCoords!,
                    width: 40,
                    height: 40,
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            
            // Marcador de destino
            if (_destinoCoords != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _destinoCoords!,
                    width: 40,
                    height: 40,
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                ],
              ),
            
            // Línea de la ruta
            if (_mostrandoRuta)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _ruta,
                    color: Colors.blue.withValues(alpha: 0.7),
                    strokeWidth: 4,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormularioViaje() {
    return Column(
      children: [
        // Campo de origen con autocompletado
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return _lugaresFrecuentes.where((String option) {
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            _origenController.text = selection;
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: _origenController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Origen',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa el origen del viaje';
                }
                return null;
              },
            );
          },
        ),
        const SizedBox(height: 16),
        
        // Campo de destino con autocompletado
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return _lugaresFrecuentes.where((String option) {
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            _destinoController.text = selection;
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: _destinoController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Destino',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa el destino del viaje';
                }
                return null;
              },
            );
          },
        ),
        const SizedBox(height: 16),
        
        // Fila con hora y pasajeros
        Row(
          children: [
            // Campo de hora
            Expanded(
              child: TextFormField(
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
                    return 'Selecciona la hora';
                  }
                  return null;
                },
                onTap: () => _selectTime(context),
              ),
            ),
            const SizedBox(width: 16),
            
            // Selector de pasajeros
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pasajeros',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Campo de precio
        TextFormField(
          controller: _precioController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Precio por pasajero',
            prefixIcon: const Icon(Icons.attach_money),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa el precio';
            }
            if (double.tryParse(value) == null) {
              return 'Ingresa un número válido';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Botón para calcular ruta
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _calcularRuta,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.route),
            label: const Text('Calcular Ruta'),
          ),
        ),
        const SizedBox(width: 16),
        
        // Botón para crear viaje
        Expanded(
          child: ElevatedButton(
            onPressed: _crearViaje,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Crear Viaje'),
          ),
        ),
      ],
    );
  }
}
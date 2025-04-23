import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbaseprincipal.dart';

class VwViajesPasajero extends StatelessWidget {
  final List<Map<String, dynamic>> viajes = [
    {
      'origen': 'Central de Autobuses',
      'destino': 'ITP',
      'conductor': 'Juan Pérez',
      'matricula': 'A123456',
      'vehiculo': 'Versa Gris 2021',
      'hora': '07:30 AM',
      'calificacion': 4.8,
      'asientos': 3,
    },
    {
      'origen': 'Plaza Galerías',
      'destino': 'ITP',
      'conductor': 'María García',
      'matricula': 'B654321',
      'vehiculo': 'Spark Rojo 2018',
      'hora': '08:15 AM',
      'calificacion': 4.5,
      'asientos': 2,
    },
  ];

  VwViajesPasajero({super.key});

  @override
  Widget build(BuildContext context) {
    final fechaActual = DateTime.now();
    final formatoFecha = '${fechaActual.day}/${fechaActual.month}/${fechaActual.year}';

    return VwBasePrincipal(
      titulo: 'Viajes',
      subtitulo: 'Pasajero',
      child: Column(
        children: [
          // Encabezado con fecha
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Disponibles',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  formatoFecha,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Lista de viajes optimizada
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: viajes.length,
              itemBuilder: (context, index) {
                final viaje = viajes[index];
                return _buildTarjetaViaje(context, viaje);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTarjetaViaje(BuildContext context, Map<String, dynamic> viaje) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () => _mostrarDetallesConductor(context, viaje),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hora y asientos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    viaje['hora'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Chip(
                    label: Text('${viaje['asientos']} asientos'),
                    backgroundColor: Colors.green[50],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Ruta
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(viaje['origen'])),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.arrow_forward, color: Colors.grey),
                    ),
                    Expanded(
                      child: Text(
                        viaje['destino'],
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Información del conductor y vehículo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        child: Icon(Icons.person, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(viaje['conductor']),
                          Text(
                            viaje['matricula'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.directions_car, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(viaje['vehiculo']),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDetallesConductor(BuildContext context, Map<String, dynamic> viaje) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                viaje['conductor'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Matrícula: ${viaje['matricula']}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              
              // Calificación
              const Text(
                'Calificación promedio',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    viaje['calificacion'].toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Botón de cerrar
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
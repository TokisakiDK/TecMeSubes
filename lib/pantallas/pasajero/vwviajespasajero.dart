import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tec_me_subes/bases/vwbasepasajero.dart';

class VWViajesPasajero extends StatefulWidget {
  const VWViajesPasajero({super.key});

  @override
  State<VWViajesPasajero> createState() => _VWViajesPasajeroState();
}

class _VWViajesPasajeroState extends State<VWViajesPasajero> {
  // Lista dinámica de viajes (ejemplo)
  final List<Map<String, dynamic>> viajes = [
    {
      'hora': '12:30 p.m',
      'inicio': 'Fraccionamiento Los Tuzos',
      'destino': 'Instituto Tecnológico de Pachuca',
      'conductor': 'Aaron González',
      'vehiculo': 'Sentra rojo 2020',
      'calificacion': 4.5,
    },
    {
      'hora': '13:40 p.m',
      'inicio': 'Villas de Pachuca',
      'destino': 'Plaza Galerías',
      'conductor': 'Carlos Sánchez',
      'vehiculo': 'Aveo blanco 2010',
      'calificacion': null, // Sin calificación aún
    },
  ];

  int? viajeSeleccionadoIndex;

  @override
  Widget build(BuildContext context) {
    return VWBasePasajero(
      tituloPantalla: 'Viajes Disponibles',
      cuerpoPantalla: _buildBody(),
      indiceInicial: 1,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fila con "Disponibles" y fecha actual
            _buildHeaderRow(),
            const SizedBox(height: 16),
            
            // Panel de viajes
            _buildViajesPanel(),
            
            // Sección de valoración
            _buildRatingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Disponibles',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          DateFormat('dd/MM/yyyy').format(DateTime.now()),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildViajesPanel() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: viajes.isEmpty
            ? const Center(
                child: Text(
                  'No hay viajes disponibles',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : Column(
                children: [
                  ...viajes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final viaje = entry.value;
                    return Column(
                      children: [
                        _buildViajeCard(viaje, index),
                        if (index != viajes.length - 1) 
                          const Divider(height: 24),
                      ],
                    );
                  }),
                ],
              ),
      ),
    );
  }

  Widget _buildViajeCard(Map<String, dynamic> viaje, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          viajeSeleccionadoIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: viajeSeleccionadoIndex == index 
              ? Colors.blue[50] 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hora del viaje
            Text(
              viaje['hora'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Panel de ruta (gris)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      viaje['inicio'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_forward, size: 20),
                  ),
                  Expanded(
                    child: Text(
                      viaje['destino'],
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            // Info conductor y vehículo
            Row(
              children: [
                const Icon(Icons.person, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(viaje['conductor']),
                const Spacer(),
                const Icon(Icons.directions_car, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(viaje['vehiculo']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    // Si no hay viaje seleccionado
    if (viajeSeleccionadoIndex == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 24),
        child: Center(
          child: Text(
            'Sin viaje seleccionado',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    final viaje = viajes[viajeSeleccionadoIndex!];
    final calificacion = viaje['calificacion'];
    final nombreConductor = viaje['conductor'];
    
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Valoración del conductor',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Fila con icono, nombre y calificación
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono del conductor
              const Icon(Icons.person, size: 36, color: Colors.blue),
              const SizedBox(width: 12),
              
              // Nombre del conductor
              Text(
                nombreConductor,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              
              // Calificación con estrellas
              if (calificacion != null) ...[
                const Icon(Icons.star, color: Colors.amber, size: 24),
                const SizedBox(width: 4),
                Text(
                  calificacion.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('/5', style: TextStyle(fontSize: 16)),
              ] else ...[
                const Text(
                  'Sin valoración aún',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ],
          ),
          
          // Barra de progreso (si tiene calificación)
          if (calificacion != null) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: calificacion / 5,
              backgroundColor: Colors.grey[200],
              color: Colors.amber,
              minHeight: 8,
            ),
          ],
        ],
      ),
    );
  }
}
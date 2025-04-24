import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbaseconductor.dart';

class VWInicioConductor extends StatelessWidget {
  const VWInicioConductor({super.key});

  @override
  Widget build(BuildContext context) {
    return VWBaseConductor(
      tituloPantalla: 'Inicio Conductor',
      cuerpoPantalla: _buildBody(context),
      indiceInicial: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel de estado del conductor
          _buildDriverStatusPanel(),
          const SizedBox(height: 20),
          
          // Viajes activos
          _buildActiveRidesHeader(),
          const SizedBox(height: 10),
          _buildActiveRideCard(),
          const SizedBox(height: 20),
          
          // Viajes disponibles
          _buildAvailableRidesHeader(),
          const SizedBox(height: 10),
          _buildAvailableRidesList(),
        ],
      ),
    );
  }

  Widget _buildDriverStatusPanel() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Estado actual:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: true, // Este valor debería venir del estado real
                  onChanged: (value) {
                    // Lógica para cambiar estado activo/inactivo
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const LinearProgressIndicator(
              value: 0.75, // Ejemplo de progreso de rating
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 10,
            ),
            const SizedBox(height: 5),
            const Text(
              'Rating: 4.5/5.0',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveRidesHeader() {
    return const Text(
      'Tus viajes activos',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildActiveRideCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Viaje #12345',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Chip(
                  label: const Text('En curso'),
                  backgroundColor: Colors.blue[100],
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildRideDetailRow(Icons.location_on, 'ITP', '10:00 AM'),
            const SizedBox(height: 8),
            _buildRideDetailRow(Icons.location_pin, 'Plaza Galerías', '10:20 AM'),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPassengerInfo(),
                ElevatedButton(
                  onPressed: () {
                    // Acción para ver detalles del viaje
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Ver detalles'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableRidesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Viajes disponibles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            // Acción para actualizar la lista
          },
          child: const Text(
            'Actualizar',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableRidesList() {
    // Lista de ejemplo de viajes disponibles
    final availableRides = [
      {
        'origen': 'ITP',
        'destino': 'Plaza Bella',
        'hora': '11:30 AM',
        'pasajeros': 2,
        'tarifa': '\$50.00',
      },
      {
        'origen': 'Centro Histórico',
        'destino': 'Villas de Pachuca',
        'hora': '12:15 PM',
        'pasajeros': 1,
        'tarifa': '\$35.00',
      },
      {
        'origen': 'Fracc. Los Tuzos',
        'destino': 'Terminal de Autobuses',
        'hora': '1:00 PM',
        'pasajeros': 3,
        'tarifa': '\$60.00',
      },
    ];

    return Column(
      children: availableRides.map((ride) => _buildAvailableRideCard(ride)).toList(),
    );
  }

  Widget _buildAvailableRideCard(Map<String, dynamic> ride) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${ride['origen']} → ${ride['destino']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  ride['tarifa'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildRideDetailRow(Icons.access_time, ride['hora'], '${ride['pasajeros']} pasajero(s)'),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Acción para aceptar el viaje
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Aceptar viaje'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideDetailRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPassengerInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/41.jpg'),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Juan Pérez',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '4.8 ★',
              style: TextStyle(color: Colors.amber),
            ),
          ],
        ),
      ],
    );
  }
}
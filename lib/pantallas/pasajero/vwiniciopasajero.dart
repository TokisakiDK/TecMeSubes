import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbaseprincipal.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwviajespasajero.dart';

class VwInicioPasajero extends StatelessWidget {
  const VwInicioPasajero({super.key});

  @override
  Widget build(BuildContext context) {
    return VwBasePrincipal(
      titulo: 'Bienvenido',
      subtitulo: 'Pasajero',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel de búsqueda
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    '¿A dónde deseas ir hoy?',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VwViajesPasajero(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Sección de sugerencias
          const Text(
            'Destinos frecuentes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildDestinationCard('ITP', Icons.school),
                _buildDestinationCard('Centro', Icons.location_city),
                _buildDestinationCard('Galerías', Icons.shopping_cart),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Viajes recientes
          const Text(
            'Tus viajes recientes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          
          Expanded(
            child: ListView(
              children: [
                _buildRecentTrip('Juan Pérez', 'ITP', '08:30 AM'),
                _buildRecentTrip('María López', 'Centro', '10:15 AM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(String title, IconData icon) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              const SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTrip(String driver, String destination, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(driver),
        subtitle: Text(destination),
        trailing: Text(time),
        onTap: () {
          // Acción al seleccionar un viaje reciente
        },
      ),
    );
  }
}
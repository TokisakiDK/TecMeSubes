import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbaseprincipal.dart';

class VWViajesPasajero extends StatelessWidget {
  const VWViajesPasajero({super.key});

  @override
  Widget build(BuildContext context) {
    return VWBasePrincipal(
      tituloPantalla: 'Viajes Disponibles',
      cuerpoPantalla: _buildBody(context),
      indiceInicial: 1,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvailableHeader(),
            const SizedBox(height: 16),
            _buildTripList(),
            const SizedBox(height: 24),
            _buildReviewSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disponibles',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '01/04/25',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildTripList() {
    return Column(
      children: [
        _buildTripCard(
          time: '12:30 p.m',
          location: 'Fraccionamiento Los tuzos',
          transport: 'ITP',
          driver: 'Aaron Gonzalez',
          vehicle: 'Sentra rojo 2020',
        ),
        const Divider(height: 32),
        _buildTripCard(
          time: '13:40 p.m',
          location: 'Villas de Pachuca',
          transport: 'ITP',
          driver: 'Carlos Sánchez',
          vehicle: 'Aveo blanco 2010',
        ),
        const Divider(height: 32),
        _buildTripCard(
          time: '09:12 a.m',
          location: 'Por definir',
          transport: 'ITP',
          driver: 'Conductor por confirmar',
          vehicle: 'Vehículo por confirmar',
        ),
      ],
    );
  }

  Widget _buildTripCard({
    required String time,
    required String location,
    required String transport,
    required String driver,
    required String vehicle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          location,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          transport,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          driver,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          vehicle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Excelente servicio!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '[Nombre del conductor] fue muy amable y profesional durante todo el viaje. '
          'El auto estaba limpio y en perfectas condiciones. '
          'Condujo con seguridad y llegó puntual al destino. '
          'Además, fue muy cordial y respetuoso. Sin duda, lo recomendaría '
          'y volvería a viajar con él. ¡Gracias por una gran experiencia!',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () => _showAddCommentDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Agregar comentario'),
          ),
        ),
      ],
    );
  }

  void _showAddCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar comentario'),
        content: const TextField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Escribe tu comentario aquí...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Comentario agregado')));
            },
            child: const Text('Publicar'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbasepasajero.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwbuscar.dart';

class VWInicioPasajero extends StatelessWidget {
  const VWInicioPasajero({super.key});

  @override
  Widget build(BuildContext context) {
    return VWBasePasajero(
      tituloPantalla: 'Inicio Pasajero',
      cuerpoPantalla: _buildBody(context),
      indiceInicial: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDestinationBox(context),
            const SizedBox(height: 20),
            _buildSuggestionsHeader(),
            const SizedBox(height: 10),
            _buildUpdatePanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '¿A dónde desea ir?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VWBuscar()),
             );
           },
           icon: const Icon(Icons.calendar_today, size: 18),
           label: const Text('Más tarde'),
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSuggestionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Sugerencias',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Ver todo',
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildUpdatePanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text('Actualizar', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
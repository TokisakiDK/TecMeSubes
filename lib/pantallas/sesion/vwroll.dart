import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbase.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwInicioPasajero.dart';
import 'package:tec_me_subes/pantallas/vwvehiculo.dart';

class VwRoll extends StatelessWidget {
  const VwRoll({super.key});

  @override
  Widget build(BuildContext context) {
    return VwBase(
      titulo: 'Identifícate',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '¿Para qué usarás la app?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            
            // Panel Pasajero
            _buildRoleCard(
              context,
              icon: Icons.person_outline,
              title: 'Pasajero/Usuario',
              description: 'Encuentra transporte universitario',
              color: Colors.blue[600]!,
              onTap: () => _navigateToPassengerHome(context),
            ),
            const SizedBox(height: 25),
            
            // Panel Conductor
            _buildRoleCard(
              context,
              icon: Icons.directions_car,
              title: 'Conductor',
              description: 'Conductor autorizado',
              color: Colors.grey[900]!,
              onTap: () => _navigateToVehicleRegistration(context),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPassengerHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const VWInicioPasajero(),
      ),
    );
  }

  void _navigateToVehicleRegistration(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const VwVehiculo(),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.white),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
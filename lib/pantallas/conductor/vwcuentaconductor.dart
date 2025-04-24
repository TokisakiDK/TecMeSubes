import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbaseconductor.dart';

class VWCuentaConductor extends StatelessWidget {
  const VWCuentaConductor({super.key});

  @override
  Widget build(BuildContext context) {
    return VWBaseConductor(
      tituloPantalla: 'Cuenta Conductor',
      cuerpoPantalla: _buildAccountBody(context),
      indiceInicial: 2,
    );
  }

  Widget _buildAccountBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildDriverProfile(),
          const SizedBox(height: 30),
          _buildDriverStats(),
          const SizedBox(height: 30),
          _buildAccountOptions(context),
          const SizedBox(height: 30),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildDriverProfile() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
        ),
        const SizedBox(height: 20),
        const Text(
          'Carlos Mendoza',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          'Conductor - ITP',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildDriverStats() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('4.8', '★', 'Rating'),
            _buildStatItem('127', 'viajes', 'Completados'),
            _buildStatItem('95%', '👍', 'Satisfacción'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String unit, String label) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountOptions(BuildContext context) {
    return Column(
      children: [
        _buildAccountOption(
          icon: Icons.person_outline,
          title: 'Perfil del conductor',
          onTap: () => _showComingSoon(context),
        ),
        _buildAccountOption(
          icon: Icons.directions_car,
          title: 'Vehículo registrado',
          onTap: () => _showComingSoon(context),
        ),
        _buildAccountOption(
          icon: Icons.attach_money,
          title: 'Ganancias y pagos',
          onTap: () => _showComingSoon(context),
        ),
        _buildAccountOption(
          icon: Icons.star_border,
          title: 'Reseñas y calificaciones',
          onTap: () => _showComingSoon(context),
        ),
        _buildAccountOption(
          icon: Icons.settings,
          title: 'Configuración de conductor',
          onTap: () => _showComingSoon(context),
        ),
      ],
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidad en desarrollo')));
  }

  Widget _buildAccountOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[700], size: 28),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _showLogoutDialog(context),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Colors.red),
        ),
        child: const Text(
          'Cerrar sesión', 
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión como conductor?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context, 
                '/inicio-sesion', 
                (route) => false
              );
            },
            child: const Text(
              'Cerrar sesión', 
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
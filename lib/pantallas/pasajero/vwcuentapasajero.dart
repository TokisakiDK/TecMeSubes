import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbaseprincipal.dart';

class VWCuentaPasajero extends StatelessWidget {
  const VWCuentaPasajero({super.key});

  @override
  Widget build(BuildContext context) {
    return VWBasePrincipal(
      tituloPantalla: 'Mi Cuenta',
      cuerpoPantalla: _buildAccountBody(context),
      indiceInicial: 2,
    );
  }

  Widget _buildAccountBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildUserProfile(),
          const SizedBox(height: 30),
          _buildAccountOptions(context),
          const SizedBox(height: 30),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue[100],
          child: const Icon(Icons.person, size: 50, color: Colors.blue),
        ),
        const SizedBox(height: 20),
        const Text(
          'Usuario Ejemplo',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          'Estudiante - ITP', 
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildAccountOptions(BuildContext context) {
    return Column(
      children: [
        _buildAccountOption(
          icon: Icons.person_outline,
          title: 'Perfil',
          onTap: () => _showComingSoon(context),
        ),
        _buildAccountOption(
          icon: Icons.history,
          title: 'Historial de viajes',
          onTap: () => _showComingSoon(context),
        ),
        _buildAccountOption(
          icon: Icons.credit_card,
          title: 'Métodos de pago',
          onTap: () => _showComingSoon(context),
        ),
        _buildAccountOption(
          icon: Icons.notifications,
          title: 'Notificaciones',
          onTap: () => _showComingSoon(context),
        ),
        _buildAccountOption(
          icon: Icons.settings,
          title: 'Configuración',
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
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
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
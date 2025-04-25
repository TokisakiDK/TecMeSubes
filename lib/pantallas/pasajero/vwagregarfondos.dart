import 'package:flutter/material.dart';

class Vwagregarfondos extends StatelessWidget {
  const Vwagregarfondos({super.key});

  void _mostrarMensaje(BuildContext context, String cantidad) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Se han agregado $cantidad exitosamente.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildOpcion(BuildContext context, String cantidad) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue[700],
                padding: const EdgeInsets.all(12),
                child: Text(
                  cantidad,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () => _mostrarMensaje(context, cantidad),
              child: const Text('Agregar Fondos'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar fondos'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildOpcion(context, '\$20 MXN'),
                _buildOpcion(context, '\$50 MXN'),
                _buildOpcion(context, '\$100 MXN'),
                _buildOpcion(context, '\$200 MXN'),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Image.asset(
              'assets/img/TecMeSubes.jpg', 
              height: 100,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

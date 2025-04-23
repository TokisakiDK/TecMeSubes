import 'package:flutter/material.dart';

class VwBase extends StatelessWidget {
  final Widget child;
  final String? titulo;

  const VwBase({
    super.key,
    required this.child,
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Espacio superior (reducido para mover imágenes hacia arriba)
          const SizedBox(height: 20),
          
          // Contenedor de imágenes en esquinas con márgenes
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                // Imagen izquierda con posicionamiento absoluto
                Positioned(
                  left: 20, // Margen izquierdo
                  top: 10,  // Margen superior
                  child: Image.asset(
                    'assets/ITP.png',
                    width: 100, // Tamaño reducido
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholder('ITP.png', 100);
                    },
                  ),
                ),
                // Imagen derecha con posicionamiento absoluto
                Positioned(
                  right: 20, // Margen derecho
                  top: 10,   // Margen superior
                  child: Image.asset(
                    'assets/TecMeSubes.jpg',
                    width: 100, // Tamaño reducido
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholder('TecMeSubes.jpg', 100);
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Título centrado con espacio aumentado
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Text(
              titulo ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          
          // Contenido principal
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String imageName, double size) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_not_supported, size: 30, color: Colors.grey),
          Text(
            imageName,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
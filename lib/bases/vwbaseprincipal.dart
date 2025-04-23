import 'package:flutter/material.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwviajespasajero.dart';

class VwBasePrincipal extends StatefulWidget {
  final Widget child;
  final String titulo;
  final String subtitulo;

  const VwBasePrincipal({
    super.key,
    required this.child,
    required this.titulo,
    required this.subtitulo,
  });

  @override
  State<VwBasePrincipal> createState() => _VwBasePrincipalState();
}

class _VwBasePrincipalState extends State<VwBasePrincipal> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Encabezado con logo y título
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            height: 140,
            decoration: BoxDecoration(
              color: Colors.blue[600],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/ITP.png',
                      width: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder('ITP.png', 80);
                      },
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.titulo,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitulo,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/TecMeSubes.jpg',
                      width: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder('TecMeSubes.jpg', 80);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Contenido principal desplazable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: widget.child,
            ),
          ),
        ],
      ),
      
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Viajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cuenta',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: (index) async {
          if (index == _currentIndex) return;

          if (index == 1) { // Botón de viajes
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VwViajesPasajero(),
              ),
            );
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // Widget para mostrar placeholder cuando falla la imagen
  Widget _buildPlaceholder(String imageName, double size) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_not_supported, size: 20, color: Colors.grey),
          Text(
            imageName,
            style: const TextStyle(fontSize: 8, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
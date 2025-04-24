import 'package:flutter/material.dart';

class VWBasePrincipal extends StatefulWidget {
  final String tituloPantalla;
  final Widget cuerpoPantalla;
  final int indiceInicial;

  const VWBasePrincipal({
    super.key,
    required this.tituloPantalla,
    required this.cuerpoPantalla,
    this.indiceInicial = 0,
  });

  @override
  State<VWBasePrincipal> createState() => _VWBasePrincipalState();
}

class _VWBasePrincipalState extends State<VWBasePrincipal> with TickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indiceInicial;
    
    // Configuración de la animación
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index, BuildContext context) {
    if (index == _currentIndex) return;
    
    // Inicia la animación de salida
    _animationController.reverse().then((_) {
      setState(() => _currentIndex = index);
      
      // Navegación con nombre
      final routes = [
        '/inicio-pasajero',
        '/viajes-pasajero',
        '/cuenta-pasajero',
      ];
      
      Navigator.pushNamedAndRemoveUntil(
        context,
        routes[index],
        (route) => false,
      );
      
      // Inicia la animación de entrada
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Panel azul superior (sin cambios)
          Container(
            height: 150,
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/ITP.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.tituloPantalla,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/TecMeSubes.jpg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          
          // Cuerpo con animación de fade
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: widget.cuerpoPantalla,
            ),
          ),
        ],
      ),
      
      // Barra de navegación inferior (sin cambios)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onItemTapped(index, context),
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
      ),
    );
  }
}
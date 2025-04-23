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

class _VWBasePrincipalState extends State<VWBasePrincipal> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indiceInicial;
  }

  void _onItemTapped(int index, BuildContext context) {
    if (index == _currentIndex) return;
    
    setState(() => _currentIndex = index);
    
    switch(index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/inicio-pasajero', 
          (route) => false
        );
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/viajes-pasajero', 
          (route) => false
        );
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/cuenta-pasajero', 
          (route) => false
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
          Expanded(child: widget.cuerpoPantalla),
        ],
      ),
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
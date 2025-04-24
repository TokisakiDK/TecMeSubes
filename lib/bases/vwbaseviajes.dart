import 'package:flutter/material.dart';

class VWBaseViajes extends StatefulWidget {
  final String tituloPantalla;
  final Widget cuerpoPantalla;
  final int indiceInicial;

  const VWBaseViajes({
    super.key,
    required this.tituloPantalla,
    required this.cuerpoPantalla,
    this.indiceInicial = 0,
  });

  @override
  State<VWBaseViajes> createState() => _VWBaseViajesState();
}

class _VWBaseViajesState extends State<VWBaseViajes> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indiceInicial;
  }

  void _onItemTapped(int index, BuildContext context) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    final routes = ['/buscar', '/crear-viaje'];
    Navigator.pushReplacementNamed(context, routes[index]);
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
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Crear viaje',
          ),
        ],
      ),
    );
  }
}
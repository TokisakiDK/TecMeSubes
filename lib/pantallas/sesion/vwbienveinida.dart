import 'package:flutter/material.dart';

class VwBienvenida extends StatefulWidget {
  const VwBienvenida({super.key});

  @override
  State<VwBienvenida> createState() => _VwBienvenidaState();
}

class _VwBienvenidaState extends State<VwBienvenida> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/ITP.png', height: 80),
                  const SizedBox(height: 20),
                  const Text(
                    'Bienvenido',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white, //  color del texto del botón
                textStyle: const TextStyle(fontSize: 16),
               ),
                onPressed: () => Navigator.pushNamed(context, '/inicio-sesion'),
                child: const Text('Iniciar sesión'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta?',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/registro'),
                      child: const Text(
                        'Registrarse 😄',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Image.asset('assets/TecMeSubes.jpg', height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbaseprincipal.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwiniciopasajero.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwviajespasajero.dart';
import 'package:tec_me_subes/pantallas/sesion/vwiniciosesion.dart';
import 'package:tec_me_subes/pantallas/sesion/vwpassword.dart' show VwContrasena;
import 'package:tec_me_subes/pantallas/sesion/vwregistro.dart';
import 'package:tec_me_subes/pantallas/vwroll.dart' show VwRoll;
import 'package:tec_me_subes/pantallas/vwvehiculo.dart' show VwVehiculo;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configuración mejorada para manejo de errores
  FlutterError.onError = (details) {
    debugPrint('════════════════════════════════════════════════════════════════════');
    debugPrint('ERROR: ${details.exceptionAsString()}');
    debugPrint('STACK TRACE: ${details.stack}');
    debugPrint('════════════════════════════════════════════════════════════════════');
  };
  
  // Configuración para evitar errores asíncronos no capturados
  runZonedGuarded(() {
    runApp(const TecMeSubesApp());
  }, (error, stackTrace) {
    debugPrint('════════════════════════════════════════════════════════════════════');
    debugPrint('UNCAUGHT ERROR: $error');
    debugPrint('STACK TRACE: $stackTrace');
    debugPrint('════════════════════════════════════════════════════════════════════');
  });
}

class TecMeSubesApp extends StatelessWidget {
  const TecMeSubesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TecMeSubes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      // Punto de inicio de la aplicación
      home: const VwInicioSesion(),
      // Rutas nombradas para navegación
      routes: {
        '/inicio-sesion': (context) => const VwInicioSesion(),
        '/registro': (context) => const VwRegistro(),
        '/recuperar-contrasena': (context) => const VwContrasena(),
        '/roll': (context) => const VwRoll(),
        '/vehiculo': (context) => const VwVehiculo(),
        '/inicio-pasajero': (context) => const VwInicioPasajero(),
        '/viajes-pasajero': (context) => VwViajesPasajero(), // Nota: sin const por la lista de viajes
        '/base-principal': (context) => const VwBasePrincipal(
              titulo: 'Título',
              subtitulo: 'Subtítulo',
              child: SizedBox(),
            ),
      },
      // Manejo de rutas no definidas
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Error de navegación')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(
                    'Ruta no encontrada:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    settings.name ?? 'Ruta no especificada',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
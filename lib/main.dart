import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tec_me_subes/pantallas/conductor/vwcuentaconductor.dart';
import 'package:tec_me_subes/pantallas/conductor/vwinicioconductor.dart';
import 'package:tec_me_subes/pantallas/conductor/wvviajesconductor.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwInicioPasajero.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwagregarfondos.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwbuscar.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwcuentapasajero.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwpedirviaje.dart';
import 'package:tec_me_subes/pantallas/pasajero/vwviajespasajero.dart';
import 'package:tec_me_subes/pantallas/sesion/vwbienveinida.dart';
import 'package:tec_me_subes/pantallas/sesion/vwiniciosesion.dart';
import 'package:tec_me_subes/pantallas/sesion/vwpassword.dart' show VwContrasena;
import 'package:tec_me_subes/pantallas/sesion/vwregistro.dart';
import 'package:tec_me_subes/pantallas/sesion/vwroll.dart' show VwRoll;
import 'package:tec_me_subes/pantallas/vwvehiculo.dart' show VwVehiculo;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runZonedGuarded(() {
    runApp(const TecMeSubesApp());
  }, (error, stackTrace) {
    debugPrint('UNCAUGHT ERROR: $error\nSTACK TRACE: $stackTrace');
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
      ),
      initialRoute: '/bienvenida',
      routes: {
        
        '/bienvenida': (context) => const VwBienvenida(),
        '/inicio-sesion': (context) => const VwInicioSesion(),
        '/registro': (context) => const VwRegistro(),
        '/recuperar-contrasena': (context) => const VwContrasena(),
        '/roll': (context) => const VwRoll(),
        '/vehiculo': (context) => const VwVehiculo(),
        '/inicio-pasajero': (context) => const VWInicioPasajero(),
        '/viajes-pasajero': (context) => const VWViajesPasajero(),
        '/cuenta-pasajero': (context) => const VWCuentaPasajero(),
        '/fondos': (context) => const Vwagregarfondos(),
        '/buscar': (context) => const VWBuscar(),
        '/crear-viaje': (context) => const VWPedirViaje(),
        '/inicio-conductor': (context) => const VWInicioConductor(),
        '/viajes-conductor': (context) => const VWViajesConductor(),
        '/cuenta-conductor': (context) => const VWCuentaConductor(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('Ruta no encontrada: ${settings.name}')),
      ),
    ));
  }
}
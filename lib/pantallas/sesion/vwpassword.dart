import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbase.dart' show VwBase;

class VwContrasena extends StatefulWidget {
  const VwContrasena({super.key});

  @override
  State<VwContrasena> createState() => _VwContrasenaState();
}

class _VwContrasenaState extends State<VwContrasena> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codigoController = TextEditingController();
  final _nuevaContrasenaController = TextEditingController();
  final _confirmarContrasenaController = TextEditingController();

  bool _codigoEnviado = false;
  bool _codigoVerificado = false;
  String _codigoGenerado = '';

  @override
  void dispose() {
    _emailController.dispose();
    _codigoController.dispose();
    _nuevaContrasenaController.dispose();
    _confirmarContrasenaController.dispose();
    super.dispose();
  }

  void _enviarCodigo() {
    if (_formKey.currentState!.validate()) {
      _codigoGenerado = (1000 + DateTime.now().millisecond % 9000).toString();
      
      setState(() {
        _codigoEnviado = true;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Código enviado a ${_emailController.text} (Código de prueba: $_codigoGenerado)'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _verificarCodigo() {
    if (_codigoController.text == _codigoGenerado) {
      setState(() {
        _codigoVerificado = true;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Código verificado correctamente')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Código incorrecto')),
        );
      }
    }
  }

  Future<void> _cambiarContrasena() async {
    if (_nuevaContrasenaController.text != _confirmarContrasenaController.text) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
      }
      return;
    }

    if (_nuevaContrasenaController.text.length < 6) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La contraseña debe tener al menos 6 caracteres')),
        );
      }
      return;
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña actualizada correctamente')),
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pop(context); // Regresa a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return VwBase(
      titulo: 'RECUPERAR CONTRASEÑA',
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Botón de regreso en la esquina superior izquierda
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                
                const SizedBox(height: 20),

                // Sección de correo electrónico
                if (!_codigoEnviado) ...[
                  const Text(
                    'Ingrese su correo institucional para recibir un código de verificación',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo institucional',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su correo';
                      }
                      if (!value.endsWith('@pachuca.tecnm.mx')) {
                        return 'Debe ser un correo institucional';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _enviarCodigo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'ENVIAR',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
                
                // Sección de código de verificación
                if (_codigoEnviado && !_codigoVerificado) ...[
                  const Text(
                    'Ingrese el código de 4 dígitos enviado a su correo electrónico',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _codigoController,
                    decoration: const InputDecoration(
                      labelText: 'Código de verificación',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, letterSpacing: 2),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _verificarCodigo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'VERIFICAR',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
                
                // Sección para nueva contraseña
                if (_codigoVerificado) ...[
                  const Text(
                    'Ingrese y confirme su nueva contraseña',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nuevaContrasenaController,
                    decoration: const InputDecoration(
                      labelText: 'Nueva contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmarContrasenaController,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar nueva contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _cambiarContrasena,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'CAMBIAR CONTRASEÑA',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
                
                // Opciones para regresar
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Regresar al inicio de sesión',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, '/registro');
                    }
                  },
                  child: const Text(
                    '¿No tienes cuenta? Regístrate',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbase.dart' show VwBase;

class VwInicioSesion extends StatefulWidget {
  const VwInicioSesion({super.key});

  @override
  State<VwInicioSesion> createState() => _VwInicioSesionState();
}

class _VwInicioSesionState extends State<VwInicioSesion> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //  Simulación de verificación de credenciales
  Future<bool> _verificarCredenciales(String usuario, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // Reemplaza con tu lógica real de autenticación
  }

  // Consulta del tipo de cuenta (roll)
  Future<bool> _obtenerTipoDeCuenta(String usuario) async {
    // Aquí debes consultar tu base de datos real
    await Future.delayed(const Duration(milliseconds: 500));

    // Simula que el usuario es conductor (true)
    return true;
  }

  //  Lógica principal para iniciar sesión
  Future<void> _iniciarSesion() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      final credencialesCorrectas = await _verificarCredenciales(
        _usuarioController.text,
        _passwordController.text,
      );

      if (!mounted) return;

      if (!credencialesCorrectas) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credenciales incorrectas. Verifique sus datos'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Validar si es conductor o pasajero
      final esConductor = await _obtenerTipoDeCuenta(_usuarioController.text);

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        esConductor ? '/inicio-pasajero' : '/inicio-pasajero',
      );

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VwBase(
      titulo: 'INICIAR SESIÓN',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _usuarioController,
                decoration: const InputDecoration(
                  labelText: 'Correo o número de control',
                  prefixIcon: Icon(Icons.alternate_email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ingrese su correo o número de control';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      }
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ingrese su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _isLoading
                      ? null
                      : () => Navigator.pushNamed(context, '/recuperar-contrasena'),
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _iniciarSesion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('INICIAR SESIÓN'),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () => Navigator.pushNamed(context, '/registro'),
                child: const Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

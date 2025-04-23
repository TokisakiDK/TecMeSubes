import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbase.dart' show VwBase;

class VwRegistro extends StatefulWidget {
  const VwRegistro({super.key});

  @override
  State<VwRegistro> createState() => _VwRegistroState();
}

class _VwRegistroState extends State<VwRegistro> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _numeroControlController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _numeroControlController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<bool> _verificarDatosUnicos(String numeroControl, String email) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulación: en una app real aquí iría la llamada al backend
    return true; // Cambiar por lógica real
  }

  Future<void> _registrarse() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      // Verificar unicidad de datos
      final datosUnicos = await _verificarDatosUnicos(
        _numeroControlController.text,
        _emailController.text,
      );

      if (!mounted) return;

      if (!datosUnicos) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El número de control o correo ya están registrados'),
            duration: Duration(seconds: 3),
        ));
        return;
      }

      // Verificar coincidencia de contraseñas
      if (_passwordController.text != _confirmPasswordController.text) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Las contraseñas no coinciden'),
            duration: Duration(seconds: 2),
        ));
        return;
      }

      // Simular registro
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/roll');
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
      titulo: 'Crear cuenta',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              
              // Campo de nombre completo
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ingrese su nombre completo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Campo de número de control
              TextFormField(
                controller: _numeroControlController,
                decoration: const InputDecoration(
                  labelText: 'Número de control',
                  prefixIcon: Icon(Icons.confirmation_number),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ingrese su número de control';
                  }
                  if (value!.length < 8) {
                    return 'Debe tener al menos 8 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Campo de correo institucional
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo institucional',
                  hintText: 'usuario@pachuca.tecnm.mx',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ingrese su correo';
                  }
                  if (!value!.endsWith('@pachuca.tecnm.mx')) {
                    return 'Debe ser un correo institucional válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Campo de contraseña
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword 
                        ? Icons.visibility 
                        : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ingrese una contraseña';
                  }
                  if (value!.length < 8) {
                    return 'Debe tener al menos 8 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Campo de confirmación de contraseña
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword 
                        ? Icons.visibility 
                        : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              
              // Botón de registro
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _registrarse,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'REGISTRARSE',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Enlace a inicio de sesión
              TextButton(
                onPressed: _isLoading 
                    ? null 
                    : () => Navigator.pop(context),
                child: const Text(
                  '¿Ya tienes cuenta? Inicia sesión',
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
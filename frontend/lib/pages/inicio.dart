import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:go_router/go_router.dart';


class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error al iniciar sesión'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _login(BuildContext context)  async {
      final String email = _usernameController.text.trim();
      final String password = _passwordController.text.trim();

      final errorMessage = await AuthService.login(email: email, password: password);
      
      if (errorMessage == null) {
        // Inicio de sesión exitoso, redirecciona a la pantalla principal
        if (context.mounted) {
         
         context.go('/home');
        }
      } else {
        if(context.mounted){
            _showDialog(context, 'Email o contraseña erróneos.');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey, // Utiliza el GlobalKey<FormState> definido
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(image: AssetImage('assets/logoTaxi.png'), width: 250, height: 250),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu correo electrónico';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock),
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu contraseña';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login(context);
                              }
                            },
                            child: const Text('Ingresar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                    TextButton(
                      onPressed: () {
                        // Lógica para manejar la acción de "¿Olvidó su contraseña?"
                        // Puedes agregar la lógica aquí
                      },
                      child: const Text(
                        '¿Olvidó su contraseña?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Lógica para manejar la acción de "Registrarse"
                        // Puedes agregar la lógica aquí
                        context.go('/registrarse');
                      },
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        // Lógica para manejar la acción de "Ingresar como invitado"
                        // Puedes agregar la lógica aquí
                        context.go('/home');
                      },
                      child: const Text('Ingresar como invitado'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

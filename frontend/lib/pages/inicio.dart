import 'package:flutter/material.dart';
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
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          children: [
            const Image(image: AssetImage('assets/logoTaxi.png'), width: 250, height: 250,),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              textAlign: TextAlign.justify,
              controller: _passwordController,
              decoration: const InputDecoration(

                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                _login(context);
              },
              child: const Text('Ingresar'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Verificar si el usuario y la contraseña son correctos
    if (username == 'admin' && password == 'admin') {
      // Si son correctos, navegar a la página de administrador
      context.go('/adminPanel');
    } else {
      // Si son incorrectos, mostrar un mensaje de error
      setState(() {
        _errorMessage = 'Usuario o contraseña incorrectos';
      });
    }
  }
}
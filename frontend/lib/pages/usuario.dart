import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class UsuarioPage extends StatelessWidget {   //Deja este componente de Usuario por ahora, más tarde lo reviso.
  final String patente;

  const UsuarioPage({super.key, required this.patente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información conductor'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Información del Usuario para la patente $patente',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/perfilConductor'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ver Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}


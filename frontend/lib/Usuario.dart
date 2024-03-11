import 'package:flutter/material.dart';
import 'package:frontend/perfil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsuarioPage(patente: "DUIXD11"),
    );
  }
}

class UsuarioPage extends StatelessWidget {
  final String patente;

  const UsuarioPage({Key? key, required this.patente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuario'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Btn 1'),
              onTap: () {
                Navigator.pop(context); // Cerrar el menú desplegable
                // Implementar la redirección a la página principal
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            ),
          ],
        ),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfileContent()),
                );
              },
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

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: const Text('Contenido de la página principal'),
      ),
    );
  }
}

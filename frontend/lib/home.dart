import 'package:flutter/material.dart';
import 'package:frontend/components/navbar.dart';
import 'package:frontend/pages/consulta_patente.dart';
import 'package:frontend/pages/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      drawer: _drawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Implementar la funcionalidad de escanear QR aquí
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Escanear QR'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Redirigir a la pantalla de consulta de patente
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConsultaPatente()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Consultar Patente'),
            ),
          ],
        ),
      ),
    );
  }

  // Pasa el contexto como argumento
  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
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
            title: const Text('Btn 1'),
            onTap: () {
              // Implementar la funcionalidad del botón 1 aquí
            },
          ),
          ListTile(
            title: const Text('Btn 2'),
            onTap: () {
              // Implementar la funcionalidad del botón 2 aquí
            },
          ),
          ListTile(
            title: const Text('Btn 3'),
            onTap: () {
              // Implementar la funcionalidad del botón 3 aquí
            },
          ),
          ListTile(
            title: const Text('Administrador'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

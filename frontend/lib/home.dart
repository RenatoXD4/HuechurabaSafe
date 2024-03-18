import 'package:flutter/material.dart';
import 'package:frontend/ConsultaPatente.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('HuechurabaSafe', style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Abre el drawer
            },
          ),
        ),
      ),
      drawer: Drawer(
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
              title: const Text('Btn 4'),
              onTap: () {
                // Redirige a la pantalla de consulta de patente
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultaPatente()), // Crea una instancia de ConsultaPatente
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
            ElevatedButton(
              onPressed: () {
                // Implementar la funcionalidad de escanear QR aquí
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // color de fondo
                foregroundColor: Colors.white, // color del texto
              ),
              child: const Text('Escanear QR'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Redirigir a la pantalla de consulta de patente
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultaPatente()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // color de fondo
                foregroundColor: Colors.white, // color del texto
              ),
              child: const Text('Consultar Patente'),
            ),
          ],
        ),
      ),
    );
  }
}
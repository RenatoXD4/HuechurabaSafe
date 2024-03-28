import 'package:flutter/material.dart';
import 'package:frontend/pages/ConsultaPatente.dart';


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
                  MaterialPageRoute(builder: (context) => ConsultaPatente()),
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
}
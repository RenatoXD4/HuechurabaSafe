import 'package:flutter/material.dart';
import 'package:frontend/Usuario.dart';
import 'package:frontend/pages/login.dart';

class ConsultaPatente extends StatelessWidget {  
  const ConsultaPatente({Key? key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Consulta de Patente', style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer(); 
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
              title: const Text('Administrador'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ingrese Patente',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese la patente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UsuarioPage(patente: "DUIXD11")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}

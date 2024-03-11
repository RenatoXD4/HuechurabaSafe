import 'package:flutter/material.dart';
import 'Usuario.dart';

class ConsultaPatente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Consulta de Patente', style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
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
                // Implementar la funcionalidad del botón 1 aquí
              },
            ),
            ListTile(
              title: Text('Btn 2'),
              onTap: () {
                // Implementar la funcionalidad del botón 2 aquí
              },
            ),
            ListTile(
              title: Text('Btn 3'),
              onTap: () {
                // Implementar la funcionalidad del botón 3 aquí
              },
            ),
            ListTile(
              title: Text('Btn 4'),
              onTap: () {
                // Implementar la funcionalidad del botón 4 aquí
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
            Text(
              'Ingrese Patente',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese la patente',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsuarioPage(patente: "DUIXD11")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}

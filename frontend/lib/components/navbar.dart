import 'package:flutter/material.dart';
import 'package:frontend/pages/ConsultaPatente.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({Key? key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Asegúrate de envolver el AppBar con un Scaffold
      appBar: AppBar(
        backgroundColor: Colors.amber.shade600,
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'Menú de navegación',
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Image(
                image: AssetImage('assets/huechuraba.png'),
                height: 36,
                width: 196,
                alignment: Alignment.topLeft,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Buscar',
            onPressed: () {
              // Agregar la lógica para la búsqueda aquí
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
                // Redirigir a la página principal
                Navigator.pop(context); // Cerrar el menú desplegable
                // Agregar la lógica para redirigir a la página principal aquí
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
                // Redirigir a la pantalla de consulta de patente
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultaPatente()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

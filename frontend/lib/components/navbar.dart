import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber.shade600,
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Iniciar sesión'),
            onTap: () => context.go('/'),
          ),
          ListTile(
            title: const Text('Ver reportes'),
            onTap: () => context.go('/verReportes'),
          ),
          ListTile(
            title: const Text('Administrar'),
            onTap: () => context.go('/adminPanel'),
          ),
        ],
      ),
    );
  }
}
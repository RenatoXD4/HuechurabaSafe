import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  bool _isLoggedIn = false;
  bool _isAdmin = false; // Estado de inicio de sesión

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus();
    _loadUserInfo(); // Verificar el estado de inicio de sesión al inicializar el widget
  }

  // Método para verificar el estado de inicio de sesión
  Future<void> checkLoggedInStatus() async {
    final token = await storage.read(key: 'jwt_token');
    setState(() {
      _isLoggedIn = token != null; // Actualizar el estado según si hay un token almacenado
    });
  }

  Future<void> _loadUserInfo() async {
    try {
      final isAdmin = await AuthService.getUserInfo();
      if (isAdmin) {
        setState(() {
          _isAdmin = isAdmin; // Verificar si el usuario es administrador
        });
      }
    } catch (e) {
      print('Error al cargar la información del usuario: $e');
    }
  }


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
            if (_isAdmin)
            ListTile(
              title: const Text('Ver reportes'),
              onTap: () {

                context.go('/verReportes');
              },
            ),
            if (_isAdmin) 
              ListTile(
                title: const Text('Administrar'),
                onTap: () {
                  context.go('/adminPanel');
                },
              ),
            if (!_isLoggedIn)
              ListTile(
                title: const Text('Iniciar sesión'),
                onTap: () {
                  context.go('/');
                },
              ),
          ],
        ),
      );
    }
}


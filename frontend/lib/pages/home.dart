import 'package:flutter/material.dart';
import 'package:frontend/components/appbar.dart';
import 'package:frontend/components/navbar.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus(); // Verificar el estado de inicio de sesión al inicializar el widget
  }

  // Método para verificar el estado de inicio de sesión
  Future<void> checkLoggedInStatus() async {
    final token = await storage.read(key: 'jwt_token');
    setState(() {
      _isLoggedIn = token != null; // Actualizar el estado según si hay un token almacenado
    });
  }

  Future<void> _logout() async {
    final logoutSuccess = await AuthService.logout();
    if (logoutSuccess) {
      setState(() {
        _isLoggedIn = false; // Cambiar el estado a false después de cerrar sesión
      });
      if (mounted) {
        context.go('/');
      }
    } else {
      // Manejar error si el cierre de sesión falla
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const NavBar(),
      backgroundColor: Colors.orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset('assets/logoTaxi.png'),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/scannerQr'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.orange[800],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Escanear QR', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.go('/consultarPatente'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.orange[800],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Consultar Patente', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoggedIn)
            ElevatedButton(
              onPressed: () => _logout()
              ,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.orange[800],
                foregroundColor: Colors.white,
              ),
              child: const Text('Cerrar Sesión', style: TextStyle(fontSize: 18)),
            ),
          if (!_isLoggedIn)
            ElevatedButton(
              onPressed: () => context.go('/'), // Ir a la pantalla de inicio de sesión
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.orange[800],
                foregroundColor: Colors.white,
              ),
              child: const Text('Ir a Inicio', style: TextStyle(fontSize: 18)),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
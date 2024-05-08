import 'package:flutter/foundation.dart';
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
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    setState(() {
      _isLoggingOut = true;
    });

    final logoutSuccess = await AuthService.logout();

    setState(() {
      _isLoggingOut = false;
    });

    if (logoutSuccess) {
      if (mounted) {
        context.go('/');
        if(kDebugMode){
        print('Valor de logout: $logoutSuccess');
      }
      }
    } else {
      if(kDebugMode){
        print('Hubo un error al cerrar sesión');
      }
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
          ElevatedButton(
            onPressed: _isLoggingOut ? null : () => _logout(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.orange[800],
              foregroundColor: Colors.white,
            ),
            child: _isLoggingOut
                ? const CircularProgressIndicator() // Muestra un indicador de progreso durante el cierre de sesión
                : const Text('Cerrar Sesión', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
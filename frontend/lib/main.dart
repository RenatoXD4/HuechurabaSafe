import 'package:flutter/material.dart';
import 'package:frontend/navbar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: const NavBar(),
          body: Container(
            height: 180.0,
            width: MediaQuery.of(context).size.width,
            decoration: _boxShadow(), // Fondo del contenedor
            child: OverflowBox(
              maxHeight: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(top: 70.0),
                child: SizedBox(
                  height: 280.0,
                  width: 150.0,
                  child: CircleAvatar(
                    radius: 56,
                    backgroundColor: Colors.amber.shade600,
                    child: Padding(
                      padding: const EdgeInsets.all(25), // Border radius
                      child: ClipOval(
                        child: Image.asset('assets/persona.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxShadow() {
    return BoxDecoration(
      color: Colors.amber.shade600, // Fondo del contenedor
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Color de la sombra
          spreadRadius: 2.0, // Propagación de la sombra
          blurRadius: 5.0, // Desenfoque de la sombra
          offset: const Offset(0, 2), // Desplazamiento de la sombra
        ),
      ],
    );
  }
}

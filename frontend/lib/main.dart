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
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: _boxShadow(), // Fondo del contenedor
                      child: OverflowBox(
                        maxHeight: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          child: SizedBox(
                            height: 280.0,
                            width: 150.0,
                            child: CircleAvatar(
                              radius: 56,
                              backgroundColor: Colors.amber.shade600,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(25), // Border radius
                                child: ClipOval(
                                  child: Image.asset('assets/persona.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100.0,),
                    _texto('Nombre', _textStyle()),
                    _texto('Patente', _textStyle()),
                    _texto('Vehículo', _textStyle()),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
        color: Colors.red.shade600,
        fontWeight: FontWeight.bold,
        fontSize: 24.2,
        shadows:const [
          Shadow(
            color: Color.fromARGB(112, 0, 0, 0), // Choose the color of the shadow
            blurRadius:
                1.0, // Adjust the blur radius for the shadow effect
            offset: Offset(1.0, 1.0), // Set the horizontal and vertical offset for the shadow
          ),
        ],
    );
  }

  Center _texto(String text, TextStyle textStyle) {
    return Center(
      child: Text(
        text,
        style: textStyle,
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

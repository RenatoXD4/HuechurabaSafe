import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ConductorContent extends StatelessWidget {
  const ConductorContent({super.key});

@override
Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Perfil conductor'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 180.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: _boxShadow(context),
                  child: OverflowBox(
                    maxHeight: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.only(top: 50.0),
                      child: SizedBox(
                        height: 280.0,
                        width: 150.0,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: ClipOval(
                              child: Image.asset('assets/persona.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 95.0),
                SvgPicture.asset('assets/icon1.svg', height: 44, width: 44),
                _texto('Nombre', _textStyle(Colors.red.shade600, FontWeight.bold)),
                _texto('Juan Perez', _textStyle(Colors.black, FontWeight.normal)),
                const SizedBox(height: 10),
                SvgPicture.asset('assets/icon2.svg', height: 44, width: 44),
                _texto('Patente', _textStyle(Colors.red.shade600, FontWeight.bold)),
                _texto('DXDUI11', _textStyle(Colors.black, FontWeight.normal)),
                const SizedBox(height: 10),
                SvgPicture.asset('assets/icon3.svg', height: 44, width: 44),
                _texto('Vehículo', _textStyle(Colors.red.shade600, FontWeight.bold)),
                _texto('Ford Fiesta', _textStyle(Colors.black, FontWeight.normal)),
                const SizedBox(height: 10,),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red.shade600),
                    fixedSize: MaterialStateProperty.all(const Size.fromWidth(270)),
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                  ),
                  onPressed: () => context.go('/formReporte'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/danger.svg', height: 20, width: 20,), // Reemplaza 'assets/icono.svg' con la ubicación de tu archivo SVG
                      const SizedBox(width: 10), // Espacio entre el icono y el texto
                      _texto('Reportar conductor', _textStyle(Colors.black, FontWeight.normal)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle(Color color, FontWeight fontWeight) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: 24.2,
      shadows: const [
        Shadow(
          color: Color.fromARGB(112, 0, 0, 0),
          blurRadius: 1.0,
          offset: Offset(1.0, 1.0),
        ),
      ],
    );
  }

  Text _texto(String text, TextStyle textStyle) {
    return Text(
        text,
        style: textStyle,
      );
  }

  BoxDecoration _boxShadow(context) {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2.0,
          blurRadius: 5.0,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

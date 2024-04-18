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
        body: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,     boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],),
                  ),
                  // Contenedor circular con imagen y SVG
                  Transform.translate(
                    offset: const Offset(0, 30), // Ajusta según sea necesario para el efecto deseado
                    child: Container(
                      height: 280,
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500),
                        border: Border.all(color: Theme.of(context).primaryColor, width: 20),
                        image: const DecorationImage(
                          image: AssetImage('assets/persona.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.all(10),
                              child: const Icon(
                              Icons.verified_user,
                              color: Colors.white,
                            ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 45.0),
              _buildInfoRow(
                context,
                'assets/icon1.svg',
                'Nombre',
                'Juan Perez',
              ),
              _buildInfoRow(
                context,
                'assets/icon2.svg',
                'Patente',
                'DXDUI11',
              ),
              _buildInfoRow(
                context,
                'assets/icon3.svg',
                'Vehículo',
                'Ford Fiesta',
              ),
              const SizedBox(height: 10),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red.shade600),
                  fixedSize: MaterialStateProperty.all(
                    const Size.fromWidth(270),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                onPressed: () => context.go('/formReporte'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/danger.svg',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 10),
                    _texto(
                      'Reportar conductor',
                      _textStyle(Colors.black, FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String iconPath,
    String title,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          SvgPicture.asset(iconPath, height: 44, width: 44),
          const SizedBox(width: 10),
          Column(
            children: [
              _texto(title, _textStyle(Colors.black, FontWeight.bold)),
              _texto(content, _textStyle(Colors.black, FontWeight.normal)),
            ],
          ),
        ],
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
}

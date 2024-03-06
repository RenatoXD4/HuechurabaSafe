import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 180.0,
              width: MediaQuery.of(context).size.width,
              decoration: _boxShadow(),
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
            _texto('Benjamín Hidalgo', _textStyle(Colors.black, FontWeight.normal)),
            const SizedBox(height: 10),
            SvgPicture.asset('assets/icon2.svg', height: 44, width: 44),
            _texto('Patente', _textStyle(Colors.red.shade600, FontWeight.bold)),
            _texto('DXDUI11', _textStyle(Colors.black, FontWeight.normal)),
            const SizedBox(height: 10),
            SvgPicture.asset('assets/icon3.svg', height: 44, width: 44),
            _texto('Vehículo', _textStyle(Colors.red.shade600, FontWeight.bold)),
            _texto('Ford Fiesta', _textStyle(Colors.black, FontWeight.normal)),
          ],
        ),
      ],
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
      color: Colors.amber.shade600,
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
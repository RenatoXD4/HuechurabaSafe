import 'package:flutter/material.dart';
import 'package:frontend/services/ip_request.dart';
import 'package:frontend/services/toast_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();



class AuthService{
    static Future<String?> login({required String email, required String password}) async {
      try {
        final response = await http.post(
          Uri.parse('http://$apiIp:9090/api/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          // Almacena el token JWT en el almacenamiento seguro
          final token = json.decode(response.body)['token'];
          await storage.write(key: 'jwt_token', value: token);
          ToastService.toastService(
            'Inicio de sesión exitoso', const Color.fromARGB(255, 17, 255, 0)
            );
          return null;
        } else if (response.statusCode == 401) {
          // Nombre de usuario o contraseña incorrectos
          return 'Nombre de usuario o contraseña incorrectos';
        } else {
          // Otro error
          return 'Error desconocido';
        }
      } catch (e) {
        // Error de conexión
        return 'Error de conexión';
      }
    }

    static Future<bool> getUserInfo() async {
      try {
        final token = await storage.read(key: 'jwt_token');
        if(token != null) {
          final parts = token.split('.');
          final payload = parts[1];
          final String decodedPayload = utf8.decode(base64Url.decode(payload));
          final Map<String, dynamic> userInfo = json.decode(decodedPayload);
          
          print(userInfo);
          // Verificar el rol del usuario
          final rolId = userInfo['rol_id'];
          print('Rol id del usuario $rolId');
          if (rolId == 2) {
            // El usuario tiene el rol de administrador
            return true;
          }
        }
      } catch (e) {
        print('Error al obtener la información del usuario: $e');
      }
      return false;
    }

  static Future<bool> logout() async {
    try {
      final response = await http.get(Uri.parse('http://$apiIp:9090/api/logout'));

      if (response.statusCode == 200) {
        ToastService.toastService('Cerraste tu sesión',const Color.fromARGB(255, 255, 9, 9));

        return true; // Cierre de sesión exitoso
      } else {
        // Manejar el caso en el que la solicitud no fue exitosa
        return false; // Cierre de sesión fallido
      }
    } catch (e) {
      // Manejar errores de conexión u otros errores
      return false; // Cierre de sesión fallido
    }
  }

}
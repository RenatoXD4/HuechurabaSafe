import 'package:flutter/foundation.dart';
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
          if (kDebugMode) {
            print('Token: $token');
          }
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
          if (parts.length != 3) {
            // El token no tiene el formato esperado
            if (kDebugMode) {
              print('El token no tiene el formato esperado');
            }
            return false;
          }
          final payload = parts[1];
          final String decodedPayload = utf8.decode(base64Url.decode(payload));
          final Map<String, dynamic> userInfo = json.decode(decodedPayload);

          if (kDebugMode) {
            print(userInfo);
          }
          // Verificar el rol del usuario
          final rolId = userInfo['rol_id'];
          if (kDebugMode) {
            print('Rol id del usuario $rolId');
          }
          if (rolId == 2) {
            // El usuario tiene el rol de administrador
            return true;
          }
        }
      } catch (e) {
        // Manejar errores de manera adecuada
        if (kDebugMode) {
          print('Error al obtener la información del usuario: $e');
        }
      }
      return false;
    }
    
    static Future<bool> logout() async {
      try {
        // Eliminar el token JWT del almacenamiento seguro al cerrar sesión
        await storage.delete(key: 'jwt_token');

        // Mostrar un mensaje de éxito al usuario
        ToastService.toastService('Cerraste tu sesión', const Color.fromARGB(255, 255, 9, 9));

        // Indicar que el cierre de sesión fue exitoso
        return true;
      } catch (e) {
        // Si ocurre un error al eliminar el token, proporcionar información sobre el error
        if (kDebugMode) {
          print('Error al cerrar sesión: $e');
        }

        // Indicar que hubo un error al cerrar sesión
        return false;
      }
    }

}
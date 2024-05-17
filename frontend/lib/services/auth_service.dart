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

    static Future<Map<String, dynamic>> getUserInfo() async {
      try {
        final token = await storage.read(key: 'jwt_token');
        if(token != null) {
          final parts = token.split('.');
          if (parts.length != 3) {
            if (kDebugMode) {
              print('El token no tiene el formato esperado');
            }
            return {};
          }
          final payload = parts[1];
          final String decodedPayload = utf8.decode(base64Url.decode(payload));
          final Map<String, dynamic> userInfo = json.decode(decodedPayload);

          if (kDebugMode) {
            print(userInfo);
          }
          return userInfo;
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error al obtener la información del usuario: $e');
        }
      }
      return {};
    }
    
    static Future<bool> logout() async {
      try {
        await storage.delete(key: 'jwt_token');

        ToastService.toastService('Cerraste tu sesión', const Color.fromARGB(255, 255, 9, 9));

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('Error al cerrar sesión: $e');
        }
        return false;
      }
    }

}
import 'package:flutter/material.dart';
import 'package:frontend/services/ip_request.dart';
import 'package:frontend/services/toast_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/usuario_class.dart';


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

          final sessionId = response.headers['session-id'];


          final userResponse = await http.get(
            Uri.parse('http://$apiIp:9090/api/usuario'),
            headers: <String, String>{
              'session-id': sessionId!,
            },
          );

          if (userResponse.statusCode == 200) {

            final userData = json.decode(userResponse.body);

            final usuario = Usuario(
              id: userData['id'],
              username: userData['username'],
              email: userData['email'],
              password: '', // Recuerda, no estás enviando ni recibiendo la contraseña en texto plano
              rolId: userData['rol_id'], // Asegúrate de usar el nombre correcto del campo de rol según tu modelo
            );

            
            return null;
          } else {
            // Manejar errores al obtener los detalles del usuario
            return 'Error al obtener detalles del usuario';
          }
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

  static Future<bool> logout() async {
    try {
      final response = await http.get(Uri.parse('http://$apiIp:9090/api/logout'));

      if (response.statusCode == 200) {
        ToastService.toastService('Cerraste tu sesión',Color.fromARGB(255, 255, 9, 9));

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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/ip_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'toast_service.dart';

class UsuarioService {
  
  
  static Future<void> crearUsuario({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://$apiIp:9090/api/crearUsuario');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'username': username,
      'email': email,
      'password': password,
      'rol': "1", // ID del rol de Usuario
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      // Usuario creado correctamente
      ToastService.toastService(
        'Se ha registrado exitosamente', const Color.fromARGB(255, 17, 255, 0)
      );
    } else if (response.statusCode == 400) {
      //El correo ya existe
      final responseData = json.decode(response.body);
      final errorMessage = responseData['error'];

      throw Exception(errorMessage);
    } else {
      // Otro error
      if (kDebugMode) {
        print('Error al crear usuario: ${response.statusCode}');
      }

    }
  }


}
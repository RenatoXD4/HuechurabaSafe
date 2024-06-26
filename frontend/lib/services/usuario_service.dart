import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'toast_service.dart';

class UsuarioService {
  
  static const String netlifyUrl = 'https://astounding-sprinkles-f47c1e.netlify.app/.netlify/functions/crearCuenta';
  
  static Future<void> crearUsuario({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(netlifyUrl);
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

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Usuario creado correctamente
      ToastService.toastService(
        'Se ha registrado exitosamente', const Color.fromARGB(255, 17, 255, 0)
      );
    } else if (response.statusCode == 400) {
      //El correo ya existe
      final responseData = json.decode(utf8.decode(response.bodyBytes));
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
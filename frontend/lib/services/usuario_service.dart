import 'package:frontend/services/ip_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      print('Usuario creado correctamente');
    } else if (response.statusCode == 400) {
      //El correo ya existe
      final responseData = json.decode(response.body);
      final errorMessage = responseData['error'];

      throw Exception(errorMessage);
    } else {
      // Otro error
      print('Error al crear usuario: ${response.statusCode}');

    }
  }
}
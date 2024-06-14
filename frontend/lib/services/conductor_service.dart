import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/ip_request.dart';
import '../services/toast_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

import '../models/conductor_class.dart';


class ConductorService {
  static const String netlifyUrl = 'https://666ccbcefd6b1ae5205c6c44--astounding-sprinkles-f47c1e.netlify.app/.netlify/functions/obtenerConductor';


  static Future<void> crearConductor({
    required String nombre,
    required String patente,
    required String tipoVehiculo,
    String? fotoConductor,
  }) async {
    final url = Uri.parse('http://$apiIp:9090/api/crearConductor');
    final request = http.MultipartRequest('POST', url);
    request.fields['nombre'] = nombre;
    request.fields['patente'] = patente;
    request.fields['auto'] = tipoVehiculo;
    final token = await storage.read(key: 'jwt_token');
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';
    if (fotoConductor != null) {
      final bytes = base64Decode(fotoConductor);
      final file = http.MultipartFile.fromBytes(
        'foto',
        bytes,
        filename: 'foto.jpg',
        contentType: http_parser.MediaType('image', 'jpeg'),
      );
      request.files.add(file);
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      ToastService.toastService(
        'Conductor creado exitosamente', const Color.fromARGB(255, 17, 255, 0)
      );
    } else if (response.statusCode == 400) {
      final errorMessage = await response.stream.bytesToString();
      if (kDebugMode) {
        print('Error al crear conductor: $errorMessage');
      }
    } else {
      if (kDebugMode) {
        print('Error al crear conductor: ${response.reasonPhrase}');
      }
    }
  }

  static Future<Conductor> fetchConductor(String patente) async {
      final response = await http.get(Uri.parse('$netlifyUrl?patente=$patente'));

      if (response.statusCode == 200) {
        return Conductor.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Hubo un error al obtener el conductor');
      }
  }

  static Future<List<Conductor>> fetchConductores() async {
    try {
      final token = await storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('No se proporcionó un token de autenticación.');
      }

      final response = await http.get(
        Uri.parse('http://$apiIp:9090/api/obtenerConductores'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);

        if (jsonData is Map<String, dynamic> && jsonData.containsKey('conductor')) {
          final List<dynamic> conductoresJson = jsonData['conductor'];
          
          if (conductoresJson.isNotEmpty) {
            List<Conductor> conductores = conductoresJson
                .map((json) => Conductor.fromJson(json))
                .toList();
            
            return conductores;
          } else {
            throw Exception('La lista de conductores está vacía.');
          }
        } else {
          throw Exception('El JSON no contiene la clave "conductor" o no es un mapa válido.');
        }
      } else {
        throw Exception('Hubo un error al obtener los conductores. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Hubo un error al obtener los conductores: $e');
    }
  }


  static Future<void> actualizarConductor({
      required int id,
      required String nombre,
      required String patente,
      required String tipoVehiculo,
      String? fotoConductor,
    }) async {
      final url = Uri.parse('http://$apiIp:9090/api/updateConductor/$id');
      
      final request = http.MultipartRequest('PUT', url);
      request.fields['nombre'] = nombre;
      request.fields['patente'] = patente;
      request.fields['auto'] = tipoVehiculo;
      final token = await storage.read(key: 'jwt_token');
      request.headers['Authorization'] = 'Bearer $token';
      String nombreConductor = nombre;

      if (fotoConductor != null && !Uri.parse(fotoConductor).isAbsolute) { //Si la URL no es absoluta como una url de imagen dentro de la base de datos
        final bytes = base64Decode(fotoConductor);
        final file = http.MultipartFile.fromBytes(
          'foto',
          bytes,
          filename: 'foto.jpg',
          contentType: http_parser.MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        ToastService.toastService(
        'Conductor $nombreConductor actualizado exitosamente', const Color.fromARGB(255, 17, 255, 0)
        );
      } else {
        // Manejo de errores
        if (kDebugMode) {
          print('Error al actualizar conductor: ${response.reasonPhrase}');
        }
      }
  }

  static Future<void> deleteConductor(int id) async {
    try {
      final token = await storage.read(key: 'jwt_token');
      final response = await http.delete(
        Uri.parse('http://$apiIp:9090/api/borrarConductor/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // El conductor se eliminó correctamente
      } else {
        throw 'Error al eliminar el conductor: ${response.reasonPhrase}';
      }
    } catch (e) {
      throw 'Error al eliminar el conductor: $e';
    }
  }
}


class ConductorError implements Exception {
  final String message;
  
  ConductorError(this.message);
}
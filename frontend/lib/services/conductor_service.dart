import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/ip_request.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart' as http_parser;

import '../models/conductor_class.dart';


class ConductorService {
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
    request.headers['Content-Type'] = 'multipart/form-data';
    String nombreConductor = nombre;
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
      print('Conductor creado correctamente');
      Fluttertoast.showToast(
          msg: "Conductor $nombreConductor creado exitosamente",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 17, 255, 0),
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if (response.statusCode == 400) {
      // La patente ya está registrada
      final errorMessage = await response.stream.bytesToString();
      print('Error al crear conductor: $errorMessage');
      // Puedes manejar el error aquí según tus necesidades, como mostrar un mensaje de error
    } else {
      print('Error al crear conductor: ${response.reasonPhrase}');
      // Puedes manejar otros errores aquí según tus necesidades
    }
  }

  static Future<Conductor> fetchConductor(String patente) async { //Obtener un conductor por patente
    final response = await http
        .get(Uri.parse('http://$apiIp:9090/api/obtenerConductor/$patente'));


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Conductor.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Hubo un error al obtener el conductor');
    }
  }

  static Future<List<Conductor>> fetchConductores() async {
    final response = await http.get(Uri.parse('http://$apiIp:9090/api/obtenerConductores'));

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

      // Agregar la foto al formulario multipart solo si fotoConductor no es null y no es una URL absoluta
      if (fotoConductor != null && !Uri.parse(fotoConductor).isAbsolute) {
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
        print('Conductor actualizado correctamente');
        Fluttertoast.showToast(
          msg: "Conductor actualizado exitosamente",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 17, 255, 0),
          textColor: Colors.white,
          fontSize: 16.0
        );
        // Maneja la respuesta según tus necesidades
      } else {
        // Manejo de errores
        print('Error al actualizar conductor: ${response.reasonPhrase}');
        // Puedes manejar otros errores aquí según tus necesidades
      }
  }

  static Future<void> deleteConductor(int id) async {
    try {
      final response = await http.delete(Uri.parse('http://$apiIp:9090/api/borrarConductor/$id'));

      if (response.statusCode == 200) {
        // Si la eliminación es exitosa, no necesitamos devolver ningún dato
      } else {
        // Si hay un error en la eliminación, lanzamos una excepción con el mensaje de error
        throw 'Error al eliminar el conductor: ${response.reasonPhrase}';
      }
    } catch (e) {
      // Si ocurre una excepción, lanzamos la excepción con el mensaje de error
      throw 'Error al eliminar el conductor: $e';
    }
  }

  // Puedes agregar más funciones aquí según sea necesario
}


class ConductorError implements Exception {
  final String message;
  
  ConductorError(this.message);
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/ip_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/report_class.dart';
import 'auth_service.dart';
import 'toast_service.dart';


class ReporteService {
  
  
  static Future<void> crearReporte({
    required int razonReporte,
    required String comentarios,
    required int idUsuario,
    required int idConductor 
  }) async {
    final url = Uri.parse('http://$apiIp:9090/api/crearReporte');
    final token = await storage.read(key: 'jwt_token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'razon_reporte': razonReporte,
      'comentarios': comentarios,
      'id_usuario': idUsuario,
      'id_conductor': idConductor, 
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {

      ToastService.toastService(
        'El reporte se ha enviado exitosamente', const Color.fromARGB(255, 17, 255, 0)
      );
    } else if (response.statusCode == 400) {

      if (kDebugMode) {
        print('Error al enviar el reporte: ${response.statusCode}');
      }

      throw Exception({response.statusCode});
    } else {
      // Otro error
      if (kDebugMode) {
        print('Error al crear usuario: ${response.statusCode}');
      }

    }
  }

  static Future<List<Reporte>> obtenerReportes() async {
    final token = await storage.read(key: 'jwt_token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse('http://$apiIp:9090/api/obtenerReportes'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Reporte.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los reportes: ${response.reasonPhrase}');
    }
  }

  static Future<List<String>> obtenerRazones() async {
    try {
      final response = await http.get(Uri.parse('http://$apiIp:9090/api/razones'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => item['razon'].toString()).toList();
      } else {
        throw Exception('Error al obtener las razones');
      }
    } catch (e) {
      print('Error: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  static Future<void> borrarReporte(int id) async{
      final token = await storage.read(key: 'jwt_token');
      final response = await http.delete(
        Uri.parse('http://$apiIp:9090/api/eliminarReporte/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if(response.statusCode == 200){
         ToastService.toastService('Reporte eliminado correctamente ', const Color.fromARGB(255, 17, 255, 0));
      }else{
          if (kDebugMode) {
            print('Error al crear usuario: ${response.statusCode}');
        }
      }

  }




}
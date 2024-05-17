import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/ip_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ReporteService {
  
  
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
  }


}
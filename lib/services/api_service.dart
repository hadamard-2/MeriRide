import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://meri-ride-server.test/api';

  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/hello_api'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      debugPrint(jsonDecode(response.body).runtimeType.toString());
      debugPrint(response.body);
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to consume Laravel API');
    }
  }
}

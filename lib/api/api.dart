import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lachaudiere/models/category.dart';
import 'package:lachaudiere/models/event.dart';

class Api {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  static Future<List<Category>> getCategories() async {
    return fetchList('/categories', Category.fromJson);
  }

  static Future<List<Event>> getEvents() async {
    return fetchList('/evenements', Event.fromJson);
  }

}

Future<List<T>> fetchList<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    ) async {
  try {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Erreur HTTP: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erreur de connexion: $e');
  }
}
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class Api {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  static Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((e) => Category.fromJson(e)).toList();
      } else {
        throw Exception('Erreur HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}
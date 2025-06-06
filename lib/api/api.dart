import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';

class ApiService {

  static const String baseUrl = '';

  static Future<Event> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Event.fromJson(jsonData);
      } else {
        throw Exception('Erreur lors du chargement de l\'événement: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}
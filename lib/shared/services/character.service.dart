import 'dart:convert';

import 'package:desafio1_fteam/shared/models/api_response.model.dart';
import 'package:http/http.dart' as http;

import '../../constants/urls.constants.dart';

class CharacterService {
  static Future<ApiResponse> getCharacter({int page = 1, String? name}) async {
    try {
      final baseUri = Uri.parse(ApiConstants.character);
      final queryParams = <String, String>{'page': page.toString()};
      if (name != null && name.isNotEmpty) queryParams['name'] = name;

      final uri = baseUri.replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ApiResponse.fromJson(data);
      } else {
        throw Exception('Erro ao carregar personagens: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}

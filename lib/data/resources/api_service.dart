import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model_jellybean.dart';

class ApiService {
  static const String baseUrl = 'https://jellybellywikiapi.onrender.com/api/beans';

  Future<List<ModelJellyBean>> fetchJellyBeans() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print('API Response status: ${response.statusCode}');
      print('API Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);

        if (body['items'] != null && body['items'] is List) {
          List<dynamic> items = body['items'];
          return items.map((item) => ModelJellyBean.fromJson(item)).toList();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load jelly beans');
      }
    } catch (e) {
      print('Error fetching jelly beans: $e');
      rethrow;
    }
  }
}

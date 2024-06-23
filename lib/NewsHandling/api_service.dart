import 'dart:convert';
import 'package:danshjoyar/NewsHandling/article_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = 'https://newsapi.org/v2/everything?q=apple&from=2024-06-22&to=2024-06-22&sortBy=popularity&apiKey=e0096997807a41ed83671674b2d28f4e';

  static Future<ApiResponse> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(url));

      // Log the status code and response body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load articles: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load articles');
    }
  }
}

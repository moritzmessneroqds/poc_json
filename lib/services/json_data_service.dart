import 'dart:convert';
import 'package:dio/dio.dart';

/// Service for loading JSON data from external URLs
class JsonDataService {
  static final JsonDataService _instance = JsonDataService._internal();
  factory JsonDataService() => _instance;
  JsonDataService._internal();

  final Dio _dio = Dio();

  /// Load JSON data from a URL
  /// Returns the JSON string if successful, null if failed
  Future<String?> loadJsonFromUrl(String url) async {
    try {
      // Validate URL format
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.hasAbsolutePath) {
        throw Exception('Invalid URL format: $url');
      }

      final response = await _dio.get(url);
      
      if (response.statusCode == 200) {
        // If response is already a string, validate and return it
        if (response.data is String) {
          final jsonString = response.data as String;
          // Validate JSON format
          jsonDecode(jsonString);
          return jsonString;
        }
        // If response is a Map/List, convert to JSON string
        final jsonString = jsonEncode(response.data);
        // Validate the converted JSON
        jsonDecode(jsonString);
        return jsonString;
      } else {
        throw Exception('Failed to load JSON: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid JSON format: ${e.message}');
    } catch (e) {
      throw Exception('Error loading JSON: $e');
    }
  }

  /// Get sample JSON data for testing
  String getSampleJsonData() {
    return '''
{
  "type": "Scaffold",
  "body": {
    "type": "Center",
    "child": {
      "type": "Text",
      "data": "Local JSON - Center Text Only",
      "style": {
        "fontSize": 24.0,
        "fontWeight": "bold",
        "color": "#1976D2"
      }
    }
  }
}
''';
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKety = '';
  final String forcecastBaseUrl = 'https://api.weatherapi.com/v1/forecast.json';
  final String searchBaseUrl = 'https://api.weatherapi.com/v1/search.json';

  Future<Map<String, dynamic>> fectCurrrentWeather(String city) async {
    final url =
        '$forcecastBaseUrl?key=$apiKety&q=$city&days=1&aqi=no&alerts=no';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> fect7DayForecast(String city) async {
    final url =
        '$forcecastBaseUrl?key=$apiKety&q=$city&days=7&aqi=no&alerts=no';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  Future<List<dynamic>?> fectCitySuggestions(String query) async {
    final url = '$searchBaseUrl?key=$apiKety&q=query';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}

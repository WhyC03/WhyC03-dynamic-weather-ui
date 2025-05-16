import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather_ui/features/weather/model/weather_models.dart';

class WeatherService {
  Future<AppWeatherData> loadMockWeather(String cityName) async {
    final fileName = cityName.toLowerCase().replaceAll(" ", "_");
    final jsonStr = await rootBundle.loadString('assets/mock_data/$fileName.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonStr);
    return AppWeatherData.fromJson(jsonMap);
  }
}

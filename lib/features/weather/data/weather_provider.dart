import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_ui/core/services/weather_service.dart';
import 'package:weather_ui/features/weather/model/weather_models.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService;

  AppWeatherData? _weatherData;
  bool _isLoading = false;
  String? _error;

  AppWeatherData? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  WeatherProvider(this._weatherService);

  Future<void> loadInitialData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final city = prefs.getString('selectedCityName') ?? 'New York';
      final isCelsius = prefs.getBool('isCelsius') ?? true;

      final data = await _weatherService.loadMockWeather(city);

      _weatherData = data.copyWith.appSettings(
        isCelsius: isCelsius,
        selectedCityName: city,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateSettings({
    required String city,
    required bool isCelsius,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCityName', city);
    await prefs.setBool('isCelsius', isCelsius);

    await loadInitialData();
  }
}

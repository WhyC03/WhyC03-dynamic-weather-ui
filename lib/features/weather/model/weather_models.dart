import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_models.freezed.dart';
part 'weather_models.g.dart';

@freezed
class AppWeatherData with _$AppWeatherData {
  const factory AppWeatherData({
    required CurrentWeather currentWeather,
    required List<DailyForecast> sevenDayForecast,
    required WeatherSettings appSettings,
  }) = _AppWeatherData;

  factory AppWeatherData.fromJson(Map<String, dynamic> json) =>
      _$AppWeatherDataFromJson(json);

  @override
  WeatherSettings get appSettings => throw UnimplementedError();

  @override
  CurrentWeather get currentWeather => throw UnimplementedError();

  @override
  List<DailyForecast> get sevenDayForecast => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

@freezed
class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather({
    required String city,
    required double temperature,
    required String conditionCode,
    required String conditionDescription,
    required int humidity,
    required double windSpeed,
    required String windDirection,
    required double feelsLike,
    required double pressure,
    required double visibility,
    required String iconId,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  @override
  String get city => throw UnimplementedError();

  @override
  String get conditionCode => throw UnimplementedError();

  @override
  String get conditionDescription => throw UnimplementedError();

  @override
  double get feelsLike => throw UnimplementedError();

  @override
  int get humidity => throw UnimplementedError();

  @override
  String get iconId => throw UnimplementedError();

  @override
  double get pressure => throw UnimplementedError();

  @override
  double get temperature => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  double get visibility => throw UnimplementedError();

  @override
  String get windDirection => throw UnimplementedError();

  @override
  double get windSpeed => throw UnimplementedError();
}

@freezed
class DailyForecast with _$DailyForecast {
  const factory DailyForecast({
    required DateTime date,
    required double highTemp,
    required double lowTemp,
    required String conditionCode,
    required String conditionDescription,
    required String iconId,
    required List<HourlyForecast> hourlyForecasts,
    required double precipitationProbability,
    required int uvIndex,
    required DateTime sunrise,
    required DateTime sunset,
  }) = _DailyForecast;

  factory DailyForecast.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastFromJson(json);

  @override
  String get conditionCode => throw UnimplementedError();

  @override
  String get conditionDescription => throw UnimplementedError();

  @override
  DateTime get date => throw UnimplementedError();

  @override
  double get highTemp => throw UnimplementedError();

  @override
  List<HourlyForecast> get hourlyForecasts => throw UnimplementedError();

  @override
  String get iconId => throw UnimplementedError();

  @override
  double get lowTemp => throw UnimplementedError();

  @override
  double get precipitationProbability => throw UnimplementedError();

  @override
  DateTime get sunrise => throw UnimplementedError();

  @override
  DateTime get sunset => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  int get uvIndex => throw UnimplementedError();
}

@freezed
class HourlyForecast with _$HourlyForecast {
  const factory HourlyForecast({
    required DateTime time,
    required double temperature,
    required String conditionCode,
    required String iconId,
  }) = _HourlyForecast;

  factory HourlyForecast.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastFromJson(json);

  @override
  String get conditionCode => throw UnimplementedError();

  @override
  String get iconId => throw UnimplementedError();

  @override
  double get temperature => throw UnimplementedError();

  @override
  DateTime get time => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

@freezed
class WeatherSettings with _$WeatherSettings {
  const factory WeatherSettings({
    required bool isCelsius,
    required String selectedCityName,
  }) = _WeatherSettings;

  factory WeatherSettings.fromJson(Map<String, dynamic> json) =>
      _$WeatherSettingsFromJson(json);

  @override
  bool get isCelsius => throw UnimplementedError();

  @override
  String get selectedCityName => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

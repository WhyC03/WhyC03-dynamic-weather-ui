import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_ui/core/services/locator.dart';
import 'package:weather_ui/core/services/weather_service.dart';
import 'package:weather_ui/features/weather/data/weather_provider.dart';
import 'package:weather_ui/features/weather/presentation/screens/home_screen.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => WeatherProvider(locator<WeatherService>())..loadInitialData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather Forecast App',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: HomeScreen(),
      ),
    );
  }
}

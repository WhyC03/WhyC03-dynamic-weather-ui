import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:weather_ui/features/weather/presentation/screens/forecast_details_scree.dart';
import 'package:weather_ui/features/weather/presentation/screens/settings_screen.dart';
import '../../data/weather_provider.dart';
import '../widgets/forecast_day_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _formatDate(DateTime date) {
    return DateFormat.E().format(date); // e.g., "Mon"
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final weatherProvider = context.watch<WeatherProvider>();
    final weatherData = weatherProvider.weatherData;

    if (weatherProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (weatherProvider.error != null) {
      return Center(child: Text('Error: ${weatherProvider.error}'));
    }

    if (weatherData == null) {
      return const Center(child: Text('No weather data available.'));
    }

    final current = weatherData.currentWeather;
    final settings = weatherData.appSettings;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
            ],

            pinned: true,
            expandedHeight: size.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${current.city} - ${settings.isCelsius ? current.temperature.toStringAsFixed(1) : (current.temperature * 9 / 5 + 32).toStringAsFixed(1)}°${settings.isCelsius ? 'C' : 'F'}',
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons
                        .wb_sunny, // You can replace with weather icon based on current.iconId
                    size: 100,
                    color: Colors.yellow.shade600,
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  _buildMetric(
                    'Humidity',
                    '${current.humidity} %',
                    Icons.water_drop,
                  ),
                  _buildMetric(
                    'Wind',
                    '${current.windSpeed} km/h ${current.windDirection}',
                    Icons.air,
                  ),
                  _buildMetric(
                    'Feels Like',
                    '${current.feelsLike.toStringAsFixed(1)}°',
                    Icons.thermostat,
                  ),
                  _buildMetric(
                    'Pressure',
                    '${current.pressure} hPa',
                    Icons.speed,
                  ),
                  _buildMetric(
                    'Visibility',
                    '${current.visibility} km',
                    Icons.visibility,
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final dayForecast = weatherData.sevenDayForecast[index];
              return ForecastDayCard(
                day: _formatDate(dayForecast.date),
                highTemp: dayForecast.highTemp,
                lowTemp: dayForecast.lowTemp,
                conditionDescription: dayForecast.conditionDescription,
                iconId: dayForecast.iconId,
                isCelsius: settings.isCelsius,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => ForecastDetailScreen(
                            forecast: dayForecast,
                            isCelsius: settings.isCelsius,
                          ),
                    ),
                  );
                },
                forecast: dayForecast,
              );
            }, childCount: weatherData.sevenDayForecast.length),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String title, String value, IconData icon) {
    return Chip(avatar: Icon(icon, size: 20), label: Text('$title: $value'));
  }
}

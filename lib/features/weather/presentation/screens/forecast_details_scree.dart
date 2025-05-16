import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/weather_models.dart';

class ForecastDetailScreen extends StatelessWidget {
  final DailyForecast forecast;
  final bool isCelsius;

  const ForecastDetailScreen({
    super.key,
    required this.forecast,
    required this.isCelsius,
  });

  String get formattedDate => DateFormat.yMMMMEEEEd().format(forecast.date);

  double convertTemp(double temp) => isCelsius ? temp : (temp * 9 / 5) + 32;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(formattedDate),
              background: Center(
                child: Icon(Icons.wb_sunny, size: 80, color: Colors.yellow),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  forecast.conditionDescription,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecast.hourlyForecasts.length,
                itemBuilder: (context, index) {
                  final hourly = forecast.hourlyForecasts[index];
                  return Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(DateFormat.Hm().format(hourly.time)),
                          const SizedBox(height: 8),
                          Icon(
                            Icons.cloud,
                            size: 30,
                          ), // Replace with iconId mapping
                          const SizedBox(height: 8),
                          Text(
                            '${convertTemp(hourly.temperature).toStringAsFixed(1)}°',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildDetail(
                      "Precipitation",
                      '${forecast.precipitationProbability.toStringAsFixed(0)} %',
                    ),
                    _buildDetail("UV Index", '${forecast.uvIndex}'),
                    _buildDetail(
                      "Sunrise",
                      DateFormat.jm().format(forecast.sunrise),
                    ),
                    _buildDetail(
                      "Sunset",
                      DateFormat.jm().format(forecast.sunset),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_ui/features/weather/model/weather_models.dart';

class ForecastDayCard extends StatelessWidget {
  final String day;
  final double highTemp;
  final double lowTemp;
  final String conditionDescription;
  final String iconId;
  final bool isCelsius;
  final VoidCallback onTap;
  final DailyForecast forecast;

  const ForecastDayCard({
    super.key,
    required this.day,
    required this.highTemp,
    required this.lowTemp,
    required this.conditionDescription,
    required this.iconId,
    required this.isCelsius,
    required this.onTap,
    required this.forecast,
  });

  double convertTemp(double celsius) =>
      isCelsius ? celsius : (celsius * 9 / 5 + 32);

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.wb_sunny),
        title: Text(day),
        subtitle: Text(conditionDescription),
        trailing: Text(
          '${convertTemp(highTemp).toStringAsFixed(1)}° / ${convertTemp(lowTemp).toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}

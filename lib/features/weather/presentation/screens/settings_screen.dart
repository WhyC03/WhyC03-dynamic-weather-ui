import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../data/weather_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const List<String> cities = [
    "New York",
    "London",
    "Paris",
    "Tokyo",
    "Sydney",
  ];

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final currentSettings = weatherProvider.weatherData?.appSettings;

    final form = FormGroup({
      'isCelsius': FormControl<bool>(value: currentSettings?.isCelsius ?? true),
      'selectedCity': FormControl<String>(
        value: currentSettings?.selectedCityName ?? 'New York',
      ),
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Color(0xffE0B6FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReactiveSwitchListTile(
                formControlName: 'isCelsius',
                title: const Text("Use Celsius"),
              ),
              const SizedBox(height: 16),
              const Text("Select City:"),
              SizedBox(height: 10),
              ReactiveDropdownField<String>(
                formControlName: 'selectedCity',
                items:
                    cities
                        .map(
                          (city) =>
                              DropdownMenuItem(value: city, child: Text(city)),
                        )
                        .toList(),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffE0B6FF),
                ),
                onPressed: () {
                  final isCelsius = form.control('isCelsius').value as bool;
                  final city = form.control('selectedCity').value as String;
                  weatherProvider.updateSettings(
                    city: city,
                    isCelsius: isCelsius,
                  );
                  Navigator.pop(context); // Go back to Home
                },
                child: const Text("Save & Apply"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

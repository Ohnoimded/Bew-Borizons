// Weather data fetcher with weather library.

import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:location/location.dart';
import 'package:todo/utilities/location_util.dart'; 

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final String _apiKey = 'YOUR_AKI_KEY'; // Private api key
  WeatherFactory? _weatherFactory;
  Weather? _weather;
  bool failsafe =false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _weatherFactory = WeatherFactory(_apiKey);
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      LocationData? locationData = await LocationUtil.getLocation(); // Gets current location using LocationUtil class
      if (locationData != null) {
        Weather weather = await _weatherFactory!.currentWeatherByLocation( // gets weather data using current lat and long
          locationData.latitude!,
          locationData.longitude!,
          
        );
        print(weather);
        setState(() {
          _weather = weather;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        failsafe = true;
        print('Location data is null. Failed to fetch weather.');
      }
    } catch (e) {
      setState(() {
        _weather = null;
        _isLoading = false;
      });
      failsafe = true;
      print('Failed to load weather data: $e');
    }
  }


// UI elements.
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SizedBox(
            width: 40,
            child: Center(
              child: CircularProgressIndicator( // Rotates when loading
                strokeWidth: 1,
                color: Colors.white,
              ),
            ),
          )
        : _weather == null
            ? Icon(Icons.error)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(

                    failsafe ==false ?
                    '${_weather!.areaName}: ${_weather!.temperature?.celsius?.toStringAsFixed(1)}°C'  : "Reload", // Area name with temp; eg: Delhi 32*C
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 2),
                  IconButton(
                    icon: Icon(
                      Icons.refresh, // refresh icon with reloader functionality
                      color: Colors.white,
                    ),
                    onPressed: fetchWeather, // reloader
                  ),
                ],
              );
  }
}

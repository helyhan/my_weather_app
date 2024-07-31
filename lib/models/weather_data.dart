import 'package:my_weather_app/models/current.dart';
import 'package:my_weather_app/models/daily.dart';
import 'package:my_weather_app/models/hourly.dart';

class WeatherData
{
  int timezoneOffset;
  Current current;
  List<Daily> daily;
  List<Hourly> hourly;

  WeatherData(Map<String, dynamic> data):
        timezoneOffset = data['timezone_offset'],
        current = Current(data['current'], data['timezone_offset']),
        daily = (data['daily'] as List).map((item) => Daily(item)).toList(),
        hourly = (data['hourly'] as List).map((item) => Hourly(item, data['timezone_offset'])).toList();
}
import 'package:my_weather_app/models/weather_data.dart';

class Location
{
  String name;
  String latitude;
  String longitude;

  WeatherData? weatherData;

  Location(this.name, this.latitude, this.longitude);
}
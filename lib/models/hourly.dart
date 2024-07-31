import 'package:intl/intl.dart';

class Hourly {
  int dt;
  double temp;
  String icon;
  double windSpeed;

  Hourly(Map<String, dynamic> data, int timezoneOffset):
      dt = data['dt'] + timezoneOffset,
      temp = data['temp'].toDouble(),
      icon = data['weather'][0]['icon'],
      windSpeed = data['wind_speed'].toDouble();

  // Getter for formatted datetime
  DateTime get dtFormatted => DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);

  // Getter for formatted time as "1AM", "3PM", etc.
  String get dtFormattedTime {
    final DateFormat formatter = DateFormat.j();
    return formatter.format(dtFormatted);
  }

  String get tempFormatted => '${temp.round()}°';

  String get iconFormatted => 'https://openweathermap.org/img/wn/$icon@2x.png';

  Map<String, dynamic> toMap() {
    return {
      'dt': dt,
      'temp': temp,
      'icon': icon,
      'windSpeed': windSpeed,
    };
  }
}
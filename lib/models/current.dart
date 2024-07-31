import 'package:intl/intl.dart';
import 'weather.dart';

class Current
{
  int dt;
  double temp;
  double feelsLike;
  int sunrise;
  int sunset;

  Weather? weather;

  Current(Map<String, dynamic> data, int timezoneOffset):
    dt = data['dt'] + timezoneOffset,
    temp = data['temp'].toDouble(),
    feelsLike = data['feels_like'].toDouble(),
    sunrise = data['sunrise'] + timezoneOffset,
    sunset = data['sunset'] + timezoneOffset,
    weather = Weather(data['weather'][0]);

  DateTime get dtFormatted {
    return DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);
  }

  String get dtFormattedLocal {
    DateFormat formatter = DateFormat('EEEE, MMM d, yyyy h:mm a');
    return formatter.format(dtFormatted);
  }

  String get tempFormatted => '${temp.round()}°';

  String get feelsLikeFormatted => '${feelsLike.round()}°';

  DateTime get sunriseFormatted {
    return DateTime.fromMillisecondsSinceEpoch(sunrise * 1000, isUtc: true);
  }

  // Getter for formatted time as "1AM", "3PM", etc.
  String get sunriseFormattedTime {
    final DateFormat formatter = DateFormat.j();
    return formatter.format(sunriseFormatted);
  }

  DateTime get sunsetFormatted {
    return DateTime.fromMillisecondsSinceEpoch(sunset * 1000, isUtc: true);
  }

  // Getter for formatted time as "1AM", "3PM", etc.
  String get sunsetFormattedTime {
    final DateFormat formatter = DateFormat.j();
    return formatter.format(sunsetFormatted);
  }



}


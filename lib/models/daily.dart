import 'package:intl/intl.dart';

class Daily {
  int dt;
  double minTemp;
  double maxTemp;
  String weatherDescription;
  String weatherIcon;

  Daily(Map<String, dynamic> data):
    dt = data['dt'],
    minTemp = data['temp']['min'].toDouble(),
    maxTemp = data['temp']['max'].toDouble(),
    weatherDescription = data['weather'][0]['description'],
    weatherIcon = data['weather'][0]['icon'];

  String get minTempFormatted => '${minTemp.round()}°';
  String get maxTempFormatted => '${maxTemp.round()}°';

  // Getter for formatted datetime
  DateTime get dtFormatted => DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);

  // Getter for day name
  String get dtFormattedDayName => DateFormat('EEEE').format(dtFormatted);

  String get minMaxTempComboFormatted => '$minTempFormatted / $maxTempFormatted';

  String get weatherDescriptionFormatted {
    return weatherDescription.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  String get weatherIconFormatted => 'https://openweathermap.org/img/wn/$weatherIcon@2x.png';

}
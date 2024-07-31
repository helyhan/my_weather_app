import 'package:flutter/cupertino.dart';
import 'package:my_weather_app/widgets/sun.dart';
import '../models/location.dart';

Widget SunTimes(Location location) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
          child: Sun(
              'Sunrise',
              location.weatherData?.current.sunriseFormattedTime ?? '6AM',
              'assets/icons/sunrise.svg'
          )
      ),
      SizedBox(width: 16),
      Expanded(
        child: Sun(
            'Sunset',
            location.weatherData?.current.sunsetFormattedTime ?? '6PM',
            'assets/icons/sunset.svg'
        ),
      )
    ],
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/models/location.dart';

Widget Week(Location location) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.deepPurple[700],
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rest of week',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          ...List.generate(5, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.deepPurple[600],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    location.weatherData?.daily[index].weatherIconFormatted ?? '-',
                    width: 64,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.weatherData?.daily[index].dtFormattedDayName ?? '-',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        location.weatherData?.daily[index].minMaxTempComboFormatted ?? '-',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    location.weatherData?.daily[index].weatherDescriptionFormatted ?? '-',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            );
          }),
        ]
    ),
  );
}
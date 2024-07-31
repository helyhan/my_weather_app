import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/models/location.dart';

Widget Today(Location location) {
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
          'Today',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 65,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      location.weatherData?.hourly[index].dtFormattedTime ?? '-',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Container(
                      width: 32,
                      child: Image.network(location.weatherData?.hourly[index].iconFormatted ?? ''),
                    ),
                    Text(
                      location.weatherData?.hourly[index].tempFormatted ?? '-',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
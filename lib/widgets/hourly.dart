import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/models/location.dart';
import 'package:my_weather_app/widgets/hourly_line_chart.dart';

Widget Hourly(Location location, String title, String type) {
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
          title,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        HourlyLineChart(location: location, type: type),
      ],
    ),
  );
}
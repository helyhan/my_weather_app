import 'package:flutter/material.dart';
import 'package:my_weather_app/widgets/bottom_bar.dart';
import 'package:my_weather_app/widgets/hourly.dart';
import 'package:my_weather_app/widgets/header.dart';
import 'package:my_weather_app/widgets/suntimes.dart';
import 'package:my_weather_app/widgets/week.dart';
import 'package:my_weather_app/widgets/today.dart';
import 'package:my_weather_app/models/location.dart';

class WeatherScreen extends StatefulWidget {

  final List<Location> locations;
  final Function(String) handleChangeSystem;

  const WeatherScreen({super.key, required this.locations, required this.handleChangeSystem});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.locations.length,
          itemBuilder: (context, index) {
            return _buildWeatherPage(widget.locations[index]);
          },
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomBar(widget.locations, _pageController, widget.handleChangeSystem)
      ),
    );
  }

  Widget _buildWeatherPage(Location location) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(location),
          SizedBox(height: 16),
          Today(location),
          SizedBox(height: 16),
          Hourly(location, "Hourly temperature", "temp"),
          SizedBox(height: 16),
          Hourly(location, "Hourly wind speed", "windSpeed"),
          SizedBox(height: 16),
          SunTimes(location),
          SizedBox(height: 16),
          Week(location),
        ],
      ),
    );
  }
}

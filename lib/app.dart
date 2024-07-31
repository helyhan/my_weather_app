import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/services/api.dart';
import 'package:my_weather_app/models/location.dart';
import 'package:my_weather_app/models/weather_data.dart';
import 'package:my_weather_app/screens/weather_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'models/settings.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  late bool loaded = false;
  late List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    load(system: "metric");
  }

  void handleChangeSystem(String value) {
    Settings.system = value;
    locations = [];
    load(system: Settings.system);
    print("Event received in parent: $value");
  }

  void load({String system = "metric"}) async {
    // Create locations
    Location miamiLocation = Location('Miami', '25.7824075', '-80.2294585');
    // Get the weather data
    final miamiResponse = await Api.get(miamiLocation.latitude, miamiLocation.longitude);
    Map<String, dynamic> miamiData = jsonDecode(miamiResponse.body);
    // Set the weather data
    miamiLocation.weatherData = WeatherData(miamiData);

    // Create locations
    Location newYorkLocation = Location('New York', '40.643006', '-74.3361736');
    // Get the weather data
    final newYorkResponse = await Api.get(newYorkLocation.latitude, newYorkLocation.longitude);
    Map<String, dynamic> newYorkData = jsonDecode(newYorkResponse.body);
    // Set the weather data
    newYorkLocation.weatherData = WeatherData(newYorkData);

    // Create locations
    Location losAngelesLocation = Location('Los Angeles', '34.020479', '-118.4117325');
    // Get the weather data
    final losAngelesResponse = await Api.get(losAngelesLocation.latitude, losAngelesLocation.longitude);
    Map<String, dynamic> losAngelesData = jsonDecode(losAngelesResponse.body);
    // Set the weather data
    losAngelesLocation.weatherData = WeatherData(losAngelesData);

    setState(() {
      locations.add(miamiLocation);
      locations.add(newYorkLocation);
      locations.add(losAngelesLocation);
      loaded = true;
    });


    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled) {
      print("location services not enabled");
    } else {
      print("location services enabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
        return;
      }
    }

    if(permission == LocationPermission.deniedForever) {
      print("Location permission denied");
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    // Create locations
    Location currentLocation = Location('Current Location', '${position.latitude}', '${position.longitude}');
    // Get the weather data
    final currentLocationResponse = await Api.get(currentLocation.latitude, currentLocation.longitude);
    Map<String, dynamic> currentLocationData = jsonDecode(currentLocationResponse.body);
    // Set the weather data
    currentLocation.weatherData = WeatherData(currentLocationData);

    setState(() {
      locations.insert(0, currentLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!loaded) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter'),
      home: WeatherScreen(locations: locations, handleChangeSystem: handleChangeSystem),
    );
  }
}

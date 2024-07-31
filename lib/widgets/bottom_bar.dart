import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_weather_app/models/settings.dart';
import '../components/circle.dart';
import '../models/location.dart';

class BottomBar extends StatefulWidget {
  final List<Location> locations;
  final PageController pageController;
  final Function(String) handleChangeSystem;

  BottomBar(this.locations, this.pageController, this.handleChangeSystem);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      bool isPage = (widget.pageController.page! % 1) != 0;
      if(isPage) {
        setState(() {
          currentPage = widget.pageController.page?.round() ?? 0;
        });
      }
    });
  }

  void _showLocationMenu() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: widget.locations.asMap().entries.map((entry) {
            int index = entry.key;
            var location = entry.value;
            return ListTile(
              title: Text(location.name),
              onTap: () {
                Navigator.pop(context);
                widget.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showTemperatureUnitMenu() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Row(
                children: [
                  Text('Metric'),
                  Spacer(),
                  if(Settings.system == "metric")
                    Icon(Icons.check, color: Colors.purple)
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                widget.handleChangeSystem("metric");
                // setState(() {
                //   _temperatureUnit = 'Celsius';
                // });
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Text('Imperial'),
                  Spacer(),
                  if(Settings.system == "imperial")
                    Icon(Icons.check, color: Colors.purple)
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                widget.handleChangeSystem("imperial");
                // setState(() {
                //   _temperatureUnit = 'Fahrenheit';
                // });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple[800],
      items: [
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: _showLocationMenu,
            child: Container(
              color: Colors.transparent,
              width: 48,
              height: 48,
              child: SvgPicture.asset(
                'assets/icons/map-marker.svg',
                width: 16,
                height: 16,
                color: Colors.white,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int index = 0; index < widget.locations.length; index++) ...[
                  Circle(isCurrentPage: index == currentPage),
                  if (index < widget.locations.length - 1) SizedBox(width: 8), // Add gap except after the last item
                ],
              ]
            )
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: _showTemperatureUnitMenu,
            child: Container(
              color: Colors.transparent,
              width: 48,
              height: 48,
              child: SvgPicture.asset(
                'assets/icons/temperature-list.svg',
                width: 16,
                height: 16,
                color: Colors.white,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
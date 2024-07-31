import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_weather_app/models/location.dart';

Widget Header(Location location) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        color: Colors.transparent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location-marker.svg',
                                width: 32,
                                height: 32,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                location.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            location.weatherData?.current?.dtFormattedLocal ?? '-',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          // SizedBox(height: 8),
          Row(
            children: [
              Text(
                location.weatherData?.current?.tempFormatted.toString() ?? "-",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 128,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.network(
                    location.weatherData?.current.weather?.iconFormatted ?? '-',
                    width: 64,
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[700],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/arrow-to-top.svg',
                          width: 16,
                          height: 16,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          location.weatherData?.daily[0].maxTempFormatted ??'-',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/icons/arrow-to-bottom.svg',
                          width: 16,
                          height: 16,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          location.weatherData?.daily[0].minTempFormatted ?? '-',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ]),
      ),
      RotatedBox(
        quarterTurns: -1,
        child: Text(
          "${location.weatherData?.daily[0].weatherDescriptionFormatted} (Feels like ${location.weatherData?.current.feelsLikeFormatted})",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}

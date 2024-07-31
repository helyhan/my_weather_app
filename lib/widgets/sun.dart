import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget Sun(String title, String time, String svgAsset) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.deepPurple[700],
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 58),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        SvgPicture.asset(
          svgAsset,
          width: 48,
          height: 48,
          color: Colors.white,
        ),
        SizedBox(height: 8),
        Text(
          time,
          style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
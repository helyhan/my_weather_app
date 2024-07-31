import 'package:flutter/material.dart';

Widget Circle({required bool isCurrentPage}) {
  return Container(
    width: 8.0,
    height: 8.0,
    decoration: BoxDecoration(
      color: isCurrentPage ? Colors.white : Colors.white70,
      shape: BoxShape.circle,
    ),
  );
}
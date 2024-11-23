import 'package:flutter/material.dart';

class TextStyles {
  TextStyle elevatedButton = const TextStyle(
      color: Colors.white,
      fontFamily: 'DMSerif',
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      letterSpacing: 2.0);

  TextStyle introTitle = const TextStyle(
      fontFamily: 'DMSerif', fontSize: 20.0, fontWeight: FontWeight.bold);

  TextStyle introInfo = const TextStyle(fontFamily: 'Mali', fontSize: 16.0);

  TextStyle daysOfWeek =
      const TextStyle(fontFamily: "DMSerif", fontWeight: FontWeight.bold);
  TextStyle calendarDays =
      const TextStyle(fontFamily: "Mali", fontWeight: FontWeight.bold);

  TextStyle nextVaccineDate = const TextStyle(
      fontFamily: "RadioCanada", fontWeight: FontWeight.bold, fontSize: 24.0);

  TextStyle sectionTitle = const TextStyle(
      fontFamily: 'RadioCanada', fontSize: 20.0, fontWeight: FontWeight.bold);

  TextStyle vaccineNames =
      const TextStyle(fontFamily: "RadioCanada", fontWeight: FontWeight.bold);
}

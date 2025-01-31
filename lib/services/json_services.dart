import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vaccination_tracker_app/models/vaccine_data.dart';

class JsonServices {
  Future<List<VaccineData>> loadVaccineData() async {
    String jsonString =
        await rootBundle.loadString('lib/assets/files/vaccines.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    List<dynamic> jsonList = jsonMap["vaccines"];

    return jsonList.map((json) => VaccineData.fromJson(json)).toList();
  }
}

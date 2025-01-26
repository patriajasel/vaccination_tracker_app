import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccination_tracker_app/models/child_information.dart';
import 'package:vaccination_tracker_app/models/guardian_information.dart';
import 'package:vaccination_tracker_app/models/user_information.dart';

/** 
 * TODO SECTION
 * 
 * ! Circular page indicator for everything that needs loading functionality
 * 
 */

final rpGuardianInfo = ChangeNotifierProvider<GuardianInformation>((ref) {
  return GuardianInformation("", "", "", 0, "", "", "", "");
});

final rpChildInfo = ChangeNotifierProvider<Children>((ref) {
  return Children([]);
});

final rpUserInfo = ChangeNotifierProvider<UserInformation>((ref) {
  return UserInformation([]);
});

final childImageLink = StateProvider<List<String>>((ref) => []);

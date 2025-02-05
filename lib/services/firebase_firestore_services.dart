// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vaccination_tracker_app/models/child_information.dart';
import 'package:vaccination_tracker_app/models/child_schedules.dart';
import 'package:vaccination_tracker_app/models/user_information.dart';
import 'package:vaccination_tracker_app/services/firebase_storage_services.dart';
import 'package:vaccination_tracker_app/services/notification_services.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/services/schedule_services.dart';

/** 
 * TODO SECTION
*/

class FirebaseFirestoreServices {
  final users = FirebaseFirestore.instance.collection("users");
  final roles = FirebaseFirestore.instance.collection("userRoles");
  final schedules = FirebaseFirestore.instance.collection('schedules');

  Future<void> createUserData(WidgetRef ref, String userID) async {
    await createGuardianDetails(ref, userID);

    final childDetails = ref.watch(rpChildInfo).children;

    print("Children Length: ${ref.watch(rpChildInfo).children.length}");

    for (var child in childDetails) {
      String childID = generateChildID();

      print("Creating Child Data...");

      await createChildDetails(userID, childID, child);
    }
  }

  Future<void> createGuardianDetails(WidgetRef ref, String userID) async {
    Map<String, dynamic> guardianInformation = {
      "guardian_surname": ref.watch(rpGuardianInfo).guardianSurname,
      "guardian_firstName": ref.watch(rpGuardianInfo).guardianFirstName,
      "guardian_middleName": ref.watch(rpGuardianInfo).guardianMiddleName,
      "guardian_age": ref.watch(rpGuardianInfo).guardianAge,
      "guardian_gender": ref.watch(rpGuardianInfo).guardianGender,
      "guardian_address": ref.watch(rpGuardianInfo).guardianAddress,
      "guardian_email": ref.watch(rpGuardianInfo).guardianEmail,
      "guardian_contact": ref.watch(rpGuardianInfo).guardianContact,
      "image_url": ''
    };

    try {
      await users.doc(userID).set(guardianInformation);

      await FirebaseStorageServices().uploadGuardianImageToStorage(ref, userID);
    } catch (e) {
      print("Error creating guardian details: $e");
    }
  }

  Future<void> createChildDetails(
      String userID, String childID, ChildInformation childDetails) async {
    Map<String, dynamic> childInformation = {
      "child_nickname": childDetails.childName,
      "facility_number": childDetails.facilityNumber,
      "child_age": childDetails.childAge,
      "child_gender": childDetails.childGender,
      "child_birthdate": childDetails.childBirthDate,
      "child_birthplace": childDetails.childBirthPlace,
      "child_height": childDetails.childHeight,
      "child_weight": childDetails.childWeight,
      "child_conditions": childDetails.hConditions,
      "image_url": ''
    };

    Map<String, dynamic> vaccineInformation = {
      "bcg_vaccine": childDetails.childVaccines.bcgOption,
      "bcg_vaccine_date": childDetails.childVaccines.bcgDate,
      "hepatitisB_vaccine": childDetails.childVaccines.hepatitisBOption,
      "hepatitisB_vaccine_date": childDetails.childVaccines.hepatitisBDate,
      "pcv1_vaccine": childDetails.childVaccines.pcv1Option,
      "pcv1_vaccine_date": childDetails.childVaccines.pcv1Date,
      "pcv2_vaccine": childDetails.childVaccines.pcv2Option,
      "pcv2_vaccine_date": childDetails.childVaccines.pcv2Date,
      "pcv3_vaccine": childDetails.childVaccines.pcv3Option,
      "pcv3_vaccine_date": childDetails.childVaccines.pcv3Date,
      "opv1_vaccine": childDetails.childVaccines.opv1Option,
      "opv1_vaccine_date": childDetails.childVaccines.opv1Date,
      "opv2_vaccine": childDetails.childVaccines.opv2Option,
      "opv2_vaccine_date": childDetails.childVaccines.opv2Date,
      "opv3_vaccine": childDetails.childVaccines.opv3Option,
      "opv3_vaccine_date": childDetails.childVaccines.opv3Date,
      "ipv1_vaccine": childDetails.childVaccines.ipv1Option,
      "ipv1_vaccine_date": childDetails.childVaccines.ipv1Date,
      "ipv2_vaccine": childDetails.childVaccines.ipv2Option,
      "ipv2_vaccine_date": childDetails.childVaccines.ipv2Date,
      "pentavalent1_vaccine":
          childDetails.childVaccines.pentavalent1stDoseOption,
      "pentavalent1_vaccine_date":
          childDetails.childVaccines.pentavalent1stDate,
      "pentavalent2_vaccine":
          childDetails.childVaccines.pentavalent2ndDoseOption,
      "pentavalent2_vaccine_date":
          childDetails.childVaccines.pentavalent2ndDate,
      "pentavalent3_vaccine":
          childDetails.childVaccines.pentavalent3rdDoseOption,
      "pentavalent3_vaccine_date":
          childDetails.childVaccines.pentavalent3rdDate,
      "mmr_vaccine": childDetails.childVaccines.mmrOption,
      "mmr_vaccine_date": childDetails.childVaccines.mmrDate,
    };

    File? childImage = childDetails.childImage;

    try {
      await users
          .doc(userID)
          .collection("child")
          .doc(childID)
          .set(childInformation);

      print("Child information set successfully");

      await users
          .doc(userID)
          .collection("child")
          .doc(childID)
          .collection("vaccines")
          .doc()
          .set(vaccineInformation);

      print("Vaccine information set successfully");

      await FirebaseStorageServices()
          .uploadChildImageToStorage(childImage, userID, childID);

      print("Child image uploaded successfully");
    } catch (e) {
      print("Error creating child details: $e");
    }
  }

  Future<void> setGuardianImageUrl(String userID, String guardianUrl) async {
    try {
      await users.doc(userID).update({'image_url': guardianUrl});
    } catch (e) {
      print("Error setting guardian image url: $e");
    }
  }

  Future<void> setChildImageUrl(
      String userID, String childID, String childUrl) async {
    try {
      await users
          .doc(userID)
          .collection('child')
          .doc(childID)
          .update({'image_url': childUrl});
    } catch (e) {
      print("Error setting child image url: $e");
    }
  }

  String generateChildID() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const length = 7;
    final random = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }

  Future<void> createUserRole(String userID) async {
    await roles.doc(userID).set({"user_role": "user"});
  }

  Future<Map<String, dynamic>?> getGuardianDataFromFirebase(
      String userID) async {
    try {
      DocumentSnapshot doc = await users.doc(userID).get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>?>> getChildDataFromFirebase(
      String userID) async {
    try {
      QuerySnapshot snapshot =
          await users.doc(userID).collection('child').get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['child_id'] = doc.id;
          return data;
        }).toList();
      } else {
        print("No child data found");
        return [];
      }
    } catch (e) {
      print('Error fetching child data: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>?>> getChildVaccinesFromFirebase(
      String userID, String childID) async {
    try {
      QuerySnapshot snapshot = await users
          .doc(userID)
          .collection('child')
          .doc(childID)
          .collection('vaccines')
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return data;
        }).toList();
      } else {
        print("No Vaccine Data found");
        return [];
      }
    } catch (e) {
      print("Error getting vaccine data: $e");
      return [];
    }
  }

  Future<void> obtainUserData(String userID, WidgetRef ref) async {
    Future.microtask(() {
      ref.read(rpUserInfo.notifier).reset();
    });

    try {
      // Fetch guardian data
      Map<String, dynamic>? userData =
          await getGuardianDataFromFirebase(userID);
      // Fetch child data
      List<Map<String, dynamic>?> childData =
          await getChildDataFromFirebase(userID);

      if (userData != null && userData.isNotEmpty) {
        ref.read(rpUserInfo.notifier).name =
            "${userData['guardian_firstName']} ${userData['guardian_middleName']} ${userData['guardian_surname']} ";
        ref.read(rpUserInfo.notifier).email = userData['guardian_email'];
        ref.read(rpUserInfo.notifier).profileImage = userData['image_url'];

        List<String> imagePreferences = [];

        for (int i = 0; i < childData.length; i++) {
          imagePreferences.add('');

          List<Map<String, dynamic>?> vaccineData =
              await getChildVaccinesFromFirebase(
                  userID, childData[i]!['child_id']);

          DateTime birthDate = childData[i]!['child_birthdate'].toDate();

          ref.read(rpUserInfo.notifier).addChild(UserChildren(
              childID: childData[i]!['child_id'],
              childNickname: childData[i]!['child_nickname'],
              childImage: childData[i]!['image_url'],
              facilityNumber: childData[i]!['facility_number'],
              birthdate:
                  DateFormat('MMMM dd, yyyy').format(birthDate).toString(),
              gender: childData[i]!['child_gender'],
              birthplace: childData[i]!['child_birthplace'],
              height: childData[i]!['child_height'].toString(),
              weight: childData[i]!['child_weight'].toString(),
              vaccines: ChildVaccines(
                bcgVaccine: vaccineData[0]!['bcg_vaccine'],
                bcgDate: vaccineData[0]!['bcg_vaccine_date'] != null
                    ? (vaccineData[0]!['bcg_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                hepaVaccine: vaccineData[0]!['hepatitisB_vaccine'],
                hepaDate: vaccineData[0]!['hepatitisB_vaccine_date'] != null
                    ? (vaccineData[0]!['hepatitisB_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                opv1Vaccine: vaccineData[0]!['opv1_vaccine'],
                opv1Date: vaccineData[0]!['opv1_vaccine_date'] != null
                    ? (vaccineData[0]!['opv1_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                opv2Vaccine: vaccineData[0]!['opv2_vaccine'],
                opv2Date: vaccineData[0]!['opv2_vaccine_date'] != null
                    ? (vaccineData[0]!['opv2_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                opv3Vaccine: vaccineData[0]!['opv3_vaccine'],
                opv3Date: vaccineData[0]!['opv3_vaccine_date'] != null
                    ? (vaccineData[0]!['opv3_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                ipv1Vaccine: vaccineData[0]!['ipv1_vaccine'],
                ipv1Date: vaccineData[0]!['ipv1_vaccine_date'] != null
                    ? (vaccineData[0]!['ipv1_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                ipv2Vaccine: vaccineData[0]!['ipv2_vaccine'],
                ipv2Date: vaccineData[0]!['ipv2_vaccine_date'] != null
                    ? (vaccineData[0]!['ipv2_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                pcv1Vaccine: vaccineData[0]!['pcv1_vaccine'],
                pcv1Date: vaccineData[0]!['pcv1_vaccine_date'] != null
                    ? (vaccineData[0]!['pcv1_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                pcv2Vaccine: vaccineData[0]!['pcv2_vaccine'],
                pcv2Date: vaccineData[0]!['pcv2_vaccine_date'] != null
                    ? (vaccineData[0]!['pcv2_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                pcv3Vaccine: vaccineData[0]!['pcv3_vaccine'],
                pcv3Date: vaccineData[0]!['pcv3_vaccine_date'] != null
                    ? (vaccineData[0]!['pcv3_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
                penta1Vaccine: vaccineData[0]!['pentavalent1_vaccine'],
                penta1Date: vaccineData[0]!['pentavalent1_vaccine_date'] != null
                    ? (vaccineData[0]!['pentavalent1_vaccine_date']
                            as Timestamp)
                        .toDate()
                    : null,
                penta2Vaccine: vaccineData[0]!['pentavalent2_vaccine'],
                penta2Date: vaccineData[0]!['pentavalent2_vaccine_date'] != null
                    ? (vaccineData[0]!['pentavalent2_vaccine_date']
                            as Timestamp)
                        .toDate()
                    : null,
                penta3Vaccine: vaccineData[0]!['pentavalent3_vaccine'],
                penta3Date: vaccineData[0]!['pentavalent3_vaccine_date'] != null
                    ? (vaccineData[0]!['pentavalent3_vaccine_date']
                            as Timestamp)
                        .toDate()
                    : null,
                mmrVaccine: vaccineData[0]!['mmr_vaccine'],
                mmrDate: vaccineData[0]!['mmr_vaccine_date'] != null
                    ? (vaccineData[0]!['mmr_vaccine_date'] as Timestamp)
                        .toDate()
                    : null,
              )));
        }

        List<String> childDefaultImages = ref.read(childImageLink);

        if (childDefaultImages.length < childData.length) {
          childDefaultImages.addAll(
            List.filled(childData.length - childDefaultImages.length, ""),
          );
          ref.read(childImageLink.notifier).state = childDefaultImages;
        }

        for (int i = 0; i < childData.length; i++) {
          if (childDefaultImages[i].isEmpty) {
            childDefaultImages[i] = "";
            ref.read(childImageLink.notifier).state = childDefaultImages;
          }
        }
      }
    } catch (e, stacktrace) {
      print("Error loading data: $e");
      print("Stacktrace: $stacktrace");
    }
  }

  Future<void> updateProfileUrl(
      String newProfileLink, String documentID) async {
    try {
      await users.doc(documentID).update({'image_url': newProfileLink});
    } catch (e) {
      print("Error Updating Document: $e");
    }
  }

  Future<void> updateChildProfileUrl(
      String newProfileLink, String documentID, String childID) async {
    try {
      await users
          .doc(documentID)
          .collection('child')
          .doc(childID)
          .update({'image_url': newProfileLink});
    } catch (e) {
      print("Error Updating Document: $e");
    }
  }

  Future<void> getNewProfileImageLink(WidgetRef ref, String documentID) async {
    try {
      DocumentReference docRef = users.doc(documentID);

      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        var imageLink = docSnapshot.get('image_url');

        ref.read(rpUserInfo.notifier).updateProfileImage(imageLink);
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error getting new profile image link: $e');
    }
  }

  Future<void> getNewChildProfileImageLink(
      WidgetRef ref, String documentID, String childID, int index) async {
    try {
      DocumentReference docRef =
          users.doc(documentID).collection('child').doc(childID);

      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        var imageLink = docSnapshot.get('image_url');

        ref
            .read(rpUserInfo.notifier)
            .children[index]
            .updateChildProfileImage(imageLink);
        print('Image Successfully Updated');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error getting new profile image link: $e');
    }
  }

  Future<void> updateEmailField(String email, String userID) async {
    try {
      await users.doc(userID).update({'guardian_email': email});
    } catch (e) {
      print("Error updating email: $e");
    }
  }

  Future<void> deleteChildFromFirebase(String userID, String childID) async {
    try {
      QuerySnapshot colRef = await users
          .doc(userID)
          .collection('child')
          .doc(childID)
          .collection('vaccines')
          .get();

      for (var doc in colRef.docs) {
        await doc.reference.delete();
      }

      await users.doc(userID).collection('child').doc(childID).delete();
    } catch (e) {
      print("Deleting child error: $e");
    }
  }

  Future<void> obtainAllNeededData(String userID, WidgetRef ref) async {
    Future.microtask(() {
      ref.read(rpChildScheds.notifier).reset();
    });

    await obtainUserData(userID, ref);

    if (!ref.context.mounted) return;

    final childData = ref.read(rpUserInfo);

    for (var child in childData.children) {
      await obtainChildSchedule(userID, child.childID, ref);
    }

    final schedules = ref.read(rpChildScheds);

    await NotificationServices().manageScheduledNotifications(ref);

    await ScheduleServices().trackSchedules(ref);

    await ScheduleServices()
        .manageVaccineStatus(ref, childData.children, schedules.childScheds);
  }

  Future<void> obtainChildSchedule(
      String userID, String childID, WidgetRef ref) async {
    try {
      QuerySnapshot scheduleQuery =
          await schedules.where('child_id', isEqualTo: childID).get();

      for (var schedule in scheduleQuery.docs) {
        Map<String, dynamic> scheduleData =
            schedule.data() as Map<String, dynamic>;

        ref.read(rpChildScheds.notifier).addSchedules(ScheduleModel(
            schedID: schedule.id,
            childID: childID,
            childName: scheduleData['child_name'],
            parent: scheduleData['parent'],
            schedStatus: scheduleData['schedule_status'],
            schedDate: (scheduleData['schedule_date'] as Timestamp).toDate(),
            vaccineType: scheduleData['vaccine_type']));
      }
    } catch (e, stacktrace) {
      print("Error getting child schedule: $e");
      print(stacktrace);
    }
  }
}

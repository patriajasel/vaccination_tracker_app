// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccination_tracker_app/services/firebase_firestore_services.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';

class FirebaseStorageServices {
  Future<void> uploadGuardianImageToStorage(
    WidgetRef ref,
    String userID,
  ) async {
    File? guardianImage = ref.watch(rpGuardianInfo).guardianImage;

    String trimmedID = userID.substring(0, 5);

    String guardianImageUrl = '';

    try {
      print("Uploading Guardian Image: ${guardianImage != null}");

      final guardianStorageRef = FirebaseStorage.instance
          .ref()
          .child('Users/$userID/Profile_Image/User-$trimmedID-profile.jpg');

      if (guardianImage != null) {
        final uploadTask = guardianStorageRef.putFile(guardianImage);
        final snapshot = await uploadTask;

        guardianImageUrl = await snapshot.ref.getDownloadURL();

        FirebaseFirestoreServices()
            .setGuardianImageUrl(userID, guardianImageUrl);
      }
    } catch (e) {
      print("Error uploading guardian Image; $e");
    }
  }

  Future<void> uploadChildImageToStorage(
      File? image, String userID, String childID) async {
    String childImageUrl = '';

    try {
      // Log the current state of images
      print("Uploading Child Image: ${image != null}");

      final childStorageRef = FirebaseStorage.instance
          .ref()
          .child('Users/$userID/Child/$childID/Child_Image/child-$childID.jpg');

      if (image != null) {
        final uploadTask = childStorageRef.putFile(image);

        final snapshot = await uploadTask;

        childImageUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestoreServices()
            .setChildImageUrl(userID, childID, childImageUrl);
      }
    } catch (e) {
      print("Error Uploading Child Image: $e");
    }
  }

  Future<void> replaceProfileImage(
      File newProfileImage, String documentID) async {
    String trimmedID = documentID.substring(0, 5);
    final oldImagePath =
        "Users/$documentID/Profile_Image/User-$trimmedID-profile.jpg";

    try {
      Reference oldImageReference = FirebaseStorage.instance.ref(oldImagePath);
      await oldImageReference.delete();
      print('Old image deleted successfully.');
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        print('Old image does not exist, skipping deletion.');
      } else {
        rethrow; // Re-throw unexpected exceptions
      }
    }

    try {
      String newImagePath = oldImagePath;
      Reference newImageRef = FirebaseStorage.instance.ref(newImagePath);
      UploadTask uploadTask = newImageRef.putFile(newProfileImage);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Picture successfully updated");

      FirebaseFirestoreServices().updateProfileUrl(downloadUrl, documentID);
    } catch (e) {
      print("Error uploading new image: $e");
    }
  }

  Future<void> replaceChildProfileImage(
      File newProfileImage, String documentID, String childID) async {
    final oldImagePath =
        "Users/$documentID/Child/$childID/Child_Image/child-$childID.jpg";

    try {
      Reference oldImageReference = FirebaseStorage.instance.ref(oldImagePath);
      await oldImageReference.delete();
      print('Old image deleted successfully.');
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        print('Old image does not exist, skipping deletion.');
      } else {
        rethrow; // Re-throw unexpected exceptions
      }
    }

    try {
      String newImagePath = oldImagePath;
      print(newImagePath);
      Reference newImageRef = FirebaseStorage.instance.ref(newImagePath);
      UploadTask uploadTask = newImageRef.putFile(newProfileImage);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      FirebaseFirestoreServices()
          .updateChildProfileUrl(downloadUrl, documentID, childID);
    } catch (e) {
      print("Error uploading new image: $e");
    }
  }

  Future<void> deleteChildImage(String documentID, String childID) async {
    final imagePath =
        "Users/$documentID/Child/$childID/Child_Image/child-$childID.jpg";

    try {
      Reference imageReference = FirebaseStorage.instance.ref(imagePath);
      await imageReference.delete();
      print('Old image deleted successfully.');
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        print('Old image does not exist, skipping deletion.');
      } else {
        rethrow; // Re-throw unexpected exceptions
      }
    }
  }
}

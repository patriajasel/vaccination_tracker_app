import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaccination_tracker_app/pages/about_page.dart';
import 'package:vaccination_tracker_app/pages/change_email_page.dart';
import 'package:vaccination_tracker_app/pages/change_password_page.dart';
import 'package:vaccination_tracker_app/pages/privacy_policy_page.dart';
import 'package:vaccination_tracker_app/pages/terms_and_conditions.dart';
import 'package:vaccination_tracker_app/services/firebase_firestore_services.dart';
import 'package:vaccination_tracker_app/services/firebase_storage_services.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

/** 
 * TODO SECTION 
 * ! Change Language Fucntionality
 * 
*/

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final themeColor = ref.watch(themeProvider);
    final secondaryColor = ref.watch(navIndicatorProvider);

    var userInfo = ref.watch(rpUserInfo);

    String? profileUrl = userInfo.profileImage;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeColor, Colors.white], // Colors for the gradient
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.075),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: screenWidth * 0.1,
                  leading: const Card(),
                  title: Center(
                    child: Text(
                      "Profile",
                      style: TextStyles().introTitle,
                    ),
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  trailing: IconButton(
                      onPressed: () {
                        showSignOutDialog(context);
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade800,
                            blurRadius: 8,
                            offset: const Offset(0, 0),
                          )
                        ],
                      )),
                ),

                // Display Picture Section
                SizedBox(height: screenHeight * 0.05),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: profileUrl != "" && profileUrl != null
                            ? ClipOval(
                                child: Image.network(
                                  profileUrl,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.black,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: CircleBorder(
                                side: BorderSide(
                                    width: 2, color: secondaryColor)),
                          ),
                          onPressed: () {
                            showChangeProfileImageDialog(
                                context, screenWidth, screenHeight);
                          },
                          icon: Icon(
                            Icons.photo_camera,
                            color: Colors.pink.shade300,
                            size: 25,
                          )),
                    )
                  ],
                ),

                // User Basic Information
                SizedBox(height: screenHeight * 0.01),
                Text(
                  userInfo.name,
                  style: TextStyles().sectionTitle,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(userInfo.email,
                    style: const TextStyle(fontFamily: 'Mali', fontSize: 18)),

                // General Settings Section
                SizedBox(height: screenHeight * 0.05),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.05),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("General Settings",
                        style:
                            TextStyle(fontFamily: 'RadioCanada', fontSize: 18)),
                  ),
                ),

                // Changing Email Address
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangeEmailPage()));
                    },
                    leading: const Icon(Icons.email),
                    title: const Text(
                      "Change Email Address",
                      style: TextStyle(fontFamily: "Mali"),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),

                // Changing Password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordPage()));
                    },
                    leading: const Icon(Icons.key),
                    title: const Text(
                      "Change Password",
                      style: TextStyle(fontFamily: "Mali"),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),

                // Changing Language
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: const ListTile(
                    leading: Icon(Icons.translate),
                    title: Text(
                      "Language",
                      style: TextStyle(fontFamily: "Mali"),
                    ),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),

                // Information Section
                SizedBox(height: screenHeight * 0.05),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.05),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Information",
                        style:
                            TextStyle(fontFamily: 'RadioCanada', fontSize: 18)),
                  ),
                ),

                // Terms & Conditions
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditionsPage()));
                    },
                    leading: const Icon(Icons.description),
                    title: const Text(
                      "Terms & Conditions",
                      style: TextStyle(fontFamily: "Mali"),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),

                // Privacy Policy
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyPage()));
                    },
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text(
                      "Privacy Policy",
                      style: TextStyle(fontFamily: "Mali"),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),

                // About the App
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage()));
                    },
                    leading: const Icon(Icons.smartphone),
                    title: const Text(
                      "About App",
                      style: TextStyle(fontFamily: "Mali"),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Sign Out',
            style: TextStyle(fontFamily: "RadioCanada", fontSize: 18),
          ),
          content: const Text('Are you sure you want to sign out?',
              style: TextStyle(fontFamily: "Mali", fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.cyan.shade700),
              ),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                if (FirebaseAuth.instance.currentUser == null) {
                  if (context.mounted) {
                    ref.read(rpUserInfo).reset();

                    print(
                        "Sign out child length: ${ref.watch(rpUserInfo).children.length}");

                    Navigator.popUntil(context, (route) => route.isFirst);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You have signed out')),
                    );
                  }
                }
              },
              child:
                  Text('Okay', style: TextStyle(color: Colors.cyan.shade700)),
            ),
          ],
        );
      },
    );
  }

  void showChangeProfileImageDialog(
      BuildContext context, double screenWidth, double screenHeight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use StatefulBuilder to manage the state of the dialog itself
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text(
                'Change Profile Image',
                style: TextStyle(
                    fontFamily: "RadioCanada",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                height: screenHeight * 0.3,
                width: screenWidth * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.cyan.shade400,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : null,
                        child: selectedImage == null
                            ? const Icon(
                                Icons.person,
                                size: 90,
                                color: Colors.blueGrey,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              selectedImage = File(image.path);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            foregroundColor: Colors.white),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text("Choose Photo"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.cyan.shade700),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final userID = FirebaseAuth.instance.currentUser!.uid;
                    await FirebaseStorageServices()
                        .replaceProfileImage(selectedImage!, userID);

                    await FirebaseFirestoreServices()
                        .getNewProfileImageLink(ref, userID);

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save',
                      style: TextStyle(color: Colors.cyan.shade700)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_tracker_app/models/user_information.dart';
import 'package:vaccination_tracker_app/services/firebase_firestore_services.dart';
import 'package:vaccination_tracker_app/services/firebase_storage_services.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

/**
 * TODO SECTION 
 * 
 * ! Possible Add child functionality
 * ! show no child if there is no child
 * ! delete the vaccine information as well
 */

class MyChildPage extends ConsumerStatefulWidget {
  const MyChildPage({super.key});

  @override
  ConsumerState<MyChildPage> createState() => _MyChildPageState();
}

class _MyChildPageState extends ConsumerState<MyChildPage> {
  File? selectedImage;

  String? selectedDefaultImage;

  List<bool> isTapped = List.generate(6, (index) => false);

  List<String> childImages = [
    "lib/assets/images/child-profiles/child-profile-1.png",
    "lib/assets/images/child-profiles/child-profile-2.png",
    "lib/assets/images/child-profiles/child-profile-3.png",
    "lib/assets/images/child-profiles/child-profile-4.png",
    "lib/assets/images/child-profiles/child-profile-5.png",
    "lib/assets/images/child-profiles/child-profile-6.png"
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final childData = ref.watch(rpUserInfo);

    List<String> childImagePrefs = ref.watch(childImageLink);

    bool checkVaccinesStatus(ChildVaccines vaccine) {
      if (vaccine.bcgVaccine == "No" ||
          vaccine.hepaVaccine == "No" ||
          vaccine.opv1Vaccine == "No" ||
          vaccine.opv2Vaccine == "No" ||
          vaccine.opv3Vaccine == "No" ||
          vaccine.ipv1Vaccine == "No" ||
          vaccine.ipv2Vaccine == "No" ||
          vaccine.penta1Vaccine == "No" ||
          vaccine.penta2Vaccine == "No" ||
          vaccine.penta3Vaccine == "No" ||
          vaccine.pcv1Vaccine == "No" ||
          vaccine.pcv2Vaccine == "No" ||
          vaccine.pcv3Vaccine == "No" ||
          vaccine.mmrVaccine == "No") {
        return false;
      } else {
        return true;
      }
    }

    return DefaultTabController(
        length: childData.children.length,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.cyan.shade300,
            centerTitle: true,
            title: Text(
              "My Child's Details",
              style: TextStyles().introTitle,
            ),
            bottom: childData.children.isEmpty
                ? null
                : TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              childData.children.length > 1 ? 15 : 0),
                          topRight: Radius.circular(
                              childData.children.length > 1 ? 15 : 0)),
                      color: Colors.cyan,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: Colors.blueGrey.shade700,
                    dividerColor: Colors.cyan,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "Mali"),
                    unselectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.normal),
                    tabs: List.generate(
                      childData.children.length,
                      (index) => Tab(
                        text: childData.children[index].childNickname,
                      ),
                    )),
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.cyan.shade300, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              childData.children.isEmpty
                  ? const Center(
                      child:
                          Text("You have no child registered on your account."),
                    )
                  : TabBarView(
                      children: List.generate(
                      childData.children.length,
                      (index) {
                        String? childImage =
                            ref.watch(rpUserInfo).children[index].childImage;

                        ChildVaccines vaccine =
                            ref.watch(rpUserInfo).children[index].vaccines;

                        bool isVaccineComplete = checkVaccinesStatus(vaccine);

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: screenHeight * 0.2),

                              Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.05),
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.05,
                                        horizontal: screenWidth * 0.05),
                                    decoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            CircleAvatar(
                                                radius: 40,
                                                child: childImage != "" &&
                                                        childImagePrefs[
                                                                index] ==
                                                            ""
                                                    ? ClipOval(
                                                        child: Image.network(
                                                          childImage!,
                                                          fit: BoxFit.cover,
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      )
                                                    : childImagePrefs[index] !=
                                                                "" &&
                                                            childImage == ""
                                                        ? ClipOval(
                                                            child: Image.asset(
                                                              childImagePrefs[
                                                                  index],
                                                              fit: BoxFit.cover,
                                                              height: double
                                                                  .infinity,
                                                              width: double
                                                                  .infinity,
                                                            ),
                                                          )
                                                        : const Icon(
                                                            Icons.person,
                                                            color:
                                                                Colors.blueGrey,
                                                            size: 40,
                                                          )),
                                            Positioned(
                                              height: 27.5,
                                              width: 27.5,
                                              bottom: 0,
                                              right: 0,
                                              child: IconButton(
                                                  style: IconButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 2,
                                                            color: Colors.cyan
                                                                .shade400)),
                                                  ),
                                                  onPressed: () {
                                                    showChangeChildImageDialog(
                                                      context,
                                                      screenWidth,
                                                      screenHeight,
                                                      index,
                                                      childImagePrefs,
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.photo_camera,
                                                    color: Colors.pink.shade300,
                                                    size: 20,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: screenWidth * 0.05),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nickname: ${childData.children[index].childNickname}",
                                              style: const TextStyle(
                                                  fontFamily: "Mali",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "Facility Number: ${childData.children[index].facilityNumber == "" ? "Not Available" : childData.children[index].facilityNumber}",
                                              style: const TextStyle(
                                                  fontFamily: "Mali",
                                                  fontSize: 14),
                                            ),
                                            Text(
                                                "BirthDate: ${childData.children[index].birthdate.toString()}",
                                                style: const TextStyle(
                                                    fontFamily: "Mali",
                                                    fontSize: 14))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: screenWidth * 0.05,
                                      child: IconButton(
                                          onPressed: () async {
                                            deleteChildConfirmation(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                childData
                                                    .children[index].childID);
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.black,
                                          ))),
                                ],
                              ),

                              // Other Information
                              SizedBox(height: screenHeight * 0.05),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05),
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.025,
                                      horizontal: screenWidth * 0.05),
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Other Information",
                                        style: TextStyle(
                                            fontFamily: "RadioCanada",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 1.5,
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        minTileHeight: 0,
                                        title: Text(
                                          "Gender:",
                                          style: TextStyles().titleTextStyle,
                                        ),
                                        trailing: Text(
                                          childData.children[index].gender,
                                          style: TextStyles().trailingTextStyle,
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        minTileHeight: 0,
                                        title: Text(
                                          "Place of Birth:",
                                          style: TextStyles().titleTextStyle,
                                        ),
                                        trailing: Text(
                                          childData.children[index].birthplace,
                                          style: TextStyles().trailingTextStyle,
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        minTileHeight: 0,
                                        title: Text(
                                          "Height:",
                                          style: TextStyles().titleTextStyle,
                                        ),
                                        trailing: Text(
                                          "${childData.children[index].height.toString()} cm",
                                          style: TextStyles().trailingTextStyle,
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        minTileHeight: 0,
                                        title: Text(
                                          "Weight:",
                                          style: TextStyles().titleTextStyle,
                                        ),
                                        trailing: Text(
                                          "${childData.children[index].weight.toString()} kg",
                                          style: TextStyles().trailingTextStyle,
                                        ),
                                      ),
                                    ],
                                  )),

                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05,
                                    vertical: screenHeight * 0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Vaccination Details",
                                      style: TextStyle(
                                          fontFamily: "RadioCanada",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.01),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Vaccination Status:",
                                            style: TextStyle(
                                                fontFamily: "Radio Canada",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            isVaccineComplete
                                                ? Icons.check_circle
                                                : Icons.cancel,
                                            color: isVaccineComplete
                                                ? Colors.green.shade600
                                                : Colors.red,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              isVaccineComplete
                                                  ? "Completed"
                                                  : "Incomplete",
                                              style: TextStyle(
                                                  fontFamily: "Mali",
                                                  fontSize: 18,
                                                  color: isVaccineComplete
                                                      ? Colors.green.shade600
                                                      : Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    const Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.01),
                                      child: const Text(
                                        "History:",
                                        style: TextStyle(
                                            fontFamily: "Radio Canada",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    ListView(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        ExpansionTile(
                                          title: Text(
                                            'BCG Vaccine',
                                            style:
                                                TextStyles().expansionTileTile,
                                          ),
                                          subtitle: Text(
                                            vaccine.bcgVaccine == "No"
                                                ? "Not Yet Taken"
                                                : "Complete",
                                            style: TextStyle(
                                                color:
                                                    vaccine.bcgVaccine == "No"
                                                        ? Colors.red.shade500
                                                        : Colors.green),
                                          ),
                                          leading: Icon(Icons.medical_services,
                                              color: Colors.cyan.shade700),
                                          trailing:
                                              const Icon(Icons.arrow_drop_down),
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: BCG'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.bcgVaccine == "Yes" ? "${vaccine.bcgDate}" : "Not Yet Taken"}'),
                                            ),
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text(
                                            'Hepatitis B Vaccine',
                                            style:
                                                TextStyles().expansionTileTile,
                                          ),
                                          subtitle: Text(
                                            vaccine.hepaVaccine == "No"
                                                ? "Not Yet Taken"
                                                : "Complete",
                                            style: TextStyle(
                                                color:
                                                    vaccine.hepaVaccine == "No"
                                                        ? Colors.red.shade500
                                                        : Colors.green),
                                          ),
                                          leading: Icon(Icons.medical_services,
                                              color: Colors.cyan.shade700),
                                          trailing:
                                              const Icon(Icons.arrow_drop_down),
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: Hepatitis B'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.hepaVaccine == "Yes" ? "${vaccine.hepaDate}" : "Not Yet Taken"}'),
                                            ),
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text('OPV Vaccine',
                                              style: TextStyles()
                                                  .expansionTileTile),
                                          subtitle: Text(
                                            vaccine.opv1Vaccine == "No" &&
                                                    vaccine.opv2Vaccine ==
                                                        "No" &&
                                                    vaccine.opv3Vaccine == "No"
                                                ? "Not Yet Taken"
                                                : vaccine.opv1Vaccine ==
                                                            "Yes" &&
                                                        vaccine.opv2Vaccine ==
                                                            "Yes" &&
                                                        vaccine.opv3Vaccine ==
                                                            "Yes"
                                                    ? "Completed"
                                                    : "Incomplete",
                                            style: TextStyle(
                                                color: vaccine.opv1Vaccine ==
                                                            "No" &&
                                                        vaccine.opv2Vaccine ==
                                                            "No" &&
                                                        vaccine.opv3Vaccine ==
                                                            "No"
                                                    ? Colors.red
                                                    : vaccine.opv1Vaccine ==
                                                                "Yes" &&
                                                            vaccine.opv2Vaccine ==
                                                                "Yes" &&
                                                            vaccine.opv3Vaccine ==
                                                                "Yes"
                                                        ? Colors.green.shade500
                                                        : Colors.yellowAccent
                                                            .shade700),
                                          ),
                                          leading: Icon(Icons.medical_services,
                                              color: Colors.cyan.shade700),
                                          trailing:
                                              const Icon(Icons.arrow_drop_down),
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: OPV 1'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.opv1Vaccine == "Yes" ? "${vaccine.opv1Date}" : "Not Yet Taken"}'),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: OPV 2'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.opv2Vaccine == "Yes" ? "${vaccine.opv2Date}" : "Not Yet Taken"}'),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: OPV 3'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.opv3Vaccine == "Yes" ? "${vaccine.opv3Date}" : "Not Yet Taken"}'),
                                            ),
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text('IPV Vaccine',
                                              style: TextStyles()
                                                  .expansionTileTile),
                                          subtitle: Text(
                                            vaccine.ipv1Vaccine == "No" &&
                                                    vaccine.ipv2Vaccine == "No"
                                                ? "Not Yet Taken"
                                                : vaccine.ipv1Vaccine ==
                                                            "Yes" &&
                                                        vaccine.ipv2Vaccine ==
                                                            "Yes"
                                                    ? "Completed"
                                                    : "Incomplete",
                                            style: TextStyle(
                                                color: vaccine.ipv1Vaccine ==
                                                            "No" &&
                                                        vaccine.ipv2Vaccine ==
                                                            "No"
                                                    ? Colors.red
                                                    : vaccine.ipv1Vaccine ==
                                                                "Yes" &&
                                                            vaccine.ipv2Vaccine ==
                                                                "Yes"
                                                        ? Colors.green.shade500
                                                        : Colors.yellowAccent
                                                            .shade700),
                                          ),
                                          leading: Icon(Icons.medical_services,
                                              color: Colors.cyan.shade700),
                                          trailing:
                                              const Icon(Icons.arrow_drop_down),
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: IPV 1'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.ipv1Vaccine == "Yes" ? "${vaccine.ipv1Date}" : "Not Yet Taken"}'),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: IPV 2'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.ipv2Vaccine == "Yes" ? "${vaccine.ipv2Date}" : "Not Yet Taken"}'),
                                            ),
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text('Pentavalent Vaccine',
                                              style: TextStyles()
                                                  .expansionTileTile),
                                          subtitle: Text(
                                            vaccine.penta1Vaccine == "No" &&
                                                    vaccine.penta2Vaccine ==
                                                        "No" &&
                                                    vaccine.penta3Vaccine ==
                                                        "No"
                                                ? "Not Yet Taken"
                                                : vaccine.penta1Vaccine ==
                                                            "Yes" &&
                                                        vaccine.penta2Vaccine ==
                                                            "Yes" &&
                                                        vaccine.penta3Vaccine ==
                                                            "Yes"
                                                    ? "Completed"
                                                    : "Incomplete",
                                            style: TextStyle(
                                                color: vaccine.penta1Vaccine ==
                                                            "No" &&
                                                        vaccine.penta2Vaccine ==
                                                            "No" &&
                                                        vaccine.penta3Vaccine ==
                                                            "No"
                                                    ? Colors.red
                                                    : vaccine.penta1Vaccine ==
                                                                "Yes" &&
                                                            vaccine.penta2Vaccine ==
                                                                "Yes" &&
                                                            vaccine.penta3Vaccine ==
                                                                "Yes"
                                                        ? Colors.green.shade500
                                                        : Colors.yellowAccent
                                                            .shade700),
                                          ),
                                          leading: Icon(Icons.medical_services,
                                              color: Colors.cyan.shade700),
                                          trailing:
                                              const Icon(Icons.arrow_drop_down),
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: Pentavalent 1'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.penta1Vaccine == "Yes" ? "${vaccine.penta1Date}" : "Not Yet Taken"}'),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: Pentavalent 2'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.penta2Vaccine == "Yes" ? "${vaccine.penta2Date}" : "Not Yet Taken"}'),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: Pentavalent 3'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.penta3Vaccine == "Yes" ? "${vaccine.penta3Date}" : "Not Yet Taken"}'),
                                            ),
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text('PCV Vaccine',
                                              style: TextStyles()
                                                  .expansionTileTile),
                                          subtitle: Text(
                                            vaccine.pcv1Vaccine == "No" &&
                                                    vaccine.pcv2Vaccine ==
                                                        "No" &&
                                                    vaccine.pcv3Vaccine == "No"
                                                ? "Not Yet Taken"
                                                : vaccine.pcv1Vaccine ==
                                                            "Yes" &&
                                                        vaccine.pcv2Vaccine ==
                                                            "Yes" &&
                                                        vaccine.pcv3Vaccine ==
                                                            "Yes"
                                                    ? "Completed"
                                                    : "Incomplete",
                                            style: TextStyle(
                                                color: vaccine.pcv1Vaccine ==
                                                            "No" &&
                                                        vaccine.pcv2Vaccine ==
                                                            "No" &&
                                                        vaccine.pcv3Vaccine ==
                                                            "No"
                                                    ? Colors.red
                                                    : vaccine.pcv1Vaccine ==
                                                                "Yes" &&
                                                            vaccine.pcv2Vaccine ==
                                                                "Yes" &&
                                                            vaccine.pcv3Vaccine ==
                                                                "Yes"
                                                        ? Colors.green.shade500
                                                        : Colors.yellowAccent
                                                            .shade700),
                                          ),
                                          leading: Icon(Icons.medical_services,
                                              color: Colors.cyan.shade700),
                                          trailing:
                                              const Icon(Icons.arrow_drop_down),
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: PCV 1'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.pcv1Vaccine == "Yes" ? "${vaccine.pcv1Date}" : "Not Yet Taken"}'),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: PCV 2'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.pcv2Vaccine == "Yes" ? "${vaccine.pcv2Date}" : "Not Yet Taken"}'),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: PCV 3'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.pcv3Vaccine == "Yes" ? "${vaccine.pcv3Date}" : "Not Yet Taken"}'),
                                            ),
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text('MMR Vaccine',
                                              style: TextStyles()
                                                  .expansionTileTile),
                                          subtitle: Text(
                                            vaccine.mmrVaccine == "No"
                                                ? "Not Yet Taken"
                                                : "Complete",
                                            style: TextStyle(
                                                color:
                                                    vaccine.mmrVaccine == "No"
                                                        ? Colors.red.shade500
                                                        : Colors.green),
                                          ),
                                          leading: Icon(Icons.medical_services,
                                              color: Colors.cyan.shade700),
                                          trailing:
                                              const Icon(Icons.arrow_drop_down),
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                              ),
                                              title: const Text(
                                                  'Vaccine Type: MMR'),
                                              subtitle: Text(
                                                  'Date Taken: ${vaccine.mmrVaccine == "Yes" ? "${vaccine.mmrDate}" : "Not Yet Taken"}'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )),
            ],
          ),
        ));

    /* */
  }

  void reloadState() {
    setState(() {});
  }

  void showChangeChildImageDialog(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    int index,
    List<String> childImage,
  ) {
    List<String> childDefaultImages = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              scrollable: false,
              insetPadding: const EdgeInsets.all(0),
              title: const Text(
                'Change Child Image',
                style: TextStyle(
                    fontFamily: "RadioCanada",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                height: screenHeight * 0.325,
                width: screenWidth * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.cyan.shade400,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: selectedImage != null &&
                                selectedDefaultImage == null
                            ? FileImage(selectedImage!)
                            : null,
                        child: selectedImage == null &&
                                selectedDefaultImage == null
                            ? const Icon(Icons.person,
                                size: 70, color: Colors.blueGrey)
                            : selectedDefaultImage != null
                                ? Image.asset(selectedDefaultImage!)
                                : null,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: childImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(2.5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isTapped[index]
                                    ? Colors.pinkAccent
                                    : Colors.cyan),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  for (int i = 0; i < isTapped.length; i++) {
                                    isTapped[i] = false;
                                  }
                                  isTapped[index] = true;
                                  selectedDefaultImage = childImages[index];
                                  selectedImage = null;
                                });
                              },
                              child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.cyan,
                                  child: Image.asset(childImages[index])),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
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
                              selectedDefaultImage = null;
                              for (int i = 0; i < isTapped.length; i++) {
                                isTapped[i] = false;
                              }
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
                            SizedBox(width: 5),
                            Text("Upload Photo"),
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
                    selectedDefaultImage = null;
                    selectedImage = null;
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
                    final childID =
                        ref.watch(rpUserInfo).children[index].childID;

                    if (selectedImage != null && selectedDefaultImage == null) {
                      await FirebaseStorageServices().replaceChildProfileImage(
                          selectedImage!, userID, childID);

                      await FirebaseFirestoreServices()
                          .getNewChildProfileImageLink(
                              ref, userID, childID, index);

                      selectedImage = null;
                      childDefaultImages.insert(index, "");

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } else if (selectedImage == null &&
                        selectedDefaultImage != null) {
                      childDefaultImages.insert(index, selectedDefaultImage!);

                      final prefs = await SharedPreferences.getInstance();

                      await prefs.setStringList(
                          'childProfilePicture', childDefaultImages);

                      childImage[index] = selectedDefaultImage!;

                      await FirebaseStorageServices()
                          .deleteChildImage(userID, childID);

                      await FirebaseFirestoreServices()
                          .updateChildProfileUrl("", userID, childID);

                      await FirebaseFirestoreServices()
                          .getNewChildProfileImageLink(
                              ref, userID, childID, index);

                      selectedDefaultImage = null;

                      reloadState();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } else if (selectedDefaultImage == null &&
                        selectedImage == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('You have not selected an image yet')),
                        );
                      }
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

  void deleteChildConfirmation(String userID, String childID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
              'Are you sure you want to remove this child data? All information will be lost.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestoreServices()
                    .deleteChildFromFirebase(userID, childID);

                await FirebaseFirestoreServices().obtainUserData(userID, ref);

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

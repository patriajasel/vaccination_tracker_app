import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vaccination_tracker_app/models/vaccine_data.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';

class AllAboutVaccinesPage extends ConsumerStatefulWidget {
  final int index;
  const AllAboutVaccinesPage({super.key, required this.index});

  @override
  ConsumerState<AllAboutVaccinesPage> createState() =>
      _AllAboutVaccinesPageState();
}

class _AllAboutVaccinesPageState extends ConsumerState<AllAboutVaccinesPage> {
  late BetterPlayerController videoController;

  List<String> videoDirectory = [
    'lib/assets/videos/general_video_1.mp4',
    'lib/assets/videos/general_video_2.mp4',
    'lib/assets/videos/opv_video.mp4',
    'lib/assets/videos/opv_video.mp4',
    'lib/assets/videos/general_video_3.mp4',
    'lib/assets/videos/general_video_2.mp4',
    'lib/assets/videos/general_video_2.mp4',
  ];

  List<File> videoFiles = [];

  @override
  void initState() {
    super.initState();
    videoController = BetterPlayerController(const BetterPlayerConfiguration());
    loadEverything();
  }

  void loadEverything() async {
    await _copyAssetToLocal();
  }

  Future<void> _copyAssetToLocal() async {
    try {
      var content = await rootBundle.load(videoDirectory[widget.index]);
      final directory = await getApplicationDocumentsDirectory();
      var file = File("${directory.path}/intro.mp4");
      file.writeAsBytesSync(content.buffer.asUint8List());
      _loadIntroVideo(file.path);
    } catch (e) {
      print("Error playing video: $e");
    }
  }

  void _loadIntroVideo(String fullPath) {
    videoController.setupDataSource(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        fullPath,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final themeColor = ref.watch(themeProvider);

    final List<VaccineData> vaccineData = ref.watch(rpVaccineData);

    String vaccineName = vaccineData[widget.index].vaccine;
    List<Section> vaccineSections = vaccineData[widget.index].sections;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("$vaccineName Vaccine"),
        titleTextStyle: const TextStyle(
            fontFamily: 'RadioCanada',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: themeColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [themeColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.15),
              Container(
                decoration: BoxDecoration(
                    color: Colors.cyan.shade50,
                    border: Border.all(color: Colors.cyan.shade50, width: 7)),
                height: screenHeight * 0.25,
                width: screenWidth * 0.95,
                child: BetterPlayer(controller: videoController),
              ),
              SizedBox(height: screenHeight * 0.05),
              Column(
                  children: List.generate(vaccineSections.length, (index) {
                String sectionInfo = vaccineSections[index].info;
                String sectionOpening = vaccineSections[index].opening;
                String sectionEnding = vaccineSections[index].ending;
                List<Bullet> sectionBullets = vaccineSections[index].bullets;
                List<TitledBullet> sectionTitledBullets =
                    vaccineSections[index].titledBullets;
                List<NumberedBullet> sectionNumberedBullets =
                    vaccineSections[index].numberedBullets;
                List<MiscFact> sectionMiscFact =
                    vaccineSections[index].miscAndFact;

                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.005),
                  decoration: BoxDecoration(
                      color: Colors.cyan.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.cyan, width: 2)),
                  child: ExpansionTile(
                    title: Text(
                      vaccineSections[index].title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'RadioCanada',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: const Border(),
                    leading: const Icon(Icons.info),
                    children: <Widget>[
                      if (sectionInfo.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: Text(
                            sectionInfo,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontFamily: 'RadioCanada',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      if (sectionOpening.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: Text(
                            sectionOpening,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontFamily: 'RadioCanada',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      SizedBox(height: screenHeight * 0.01),
                      if (sectionBullets.isNotEmpty)
                        ...List.generate(sectionBullets.length, (bulletIndex) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: buildBulletPoint(
                                title: sectionBullets[bulletIndex].bulletTitle,
                                text: sectionBullets[bulletIndex].moreInfo),
                          );
                        }),
                      SizedBox(height: screenHeight * 0.01),
                      if (sectionTitledBullets.isNotEmpty)
                        ...List.generate(sectionTitledBullets.length,
                            (titledIndex) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: buildTitledBullets(
                                section:
                                    sectionTitledBullets[titledIndex].section,
                                bullets:
                                    sectionTitledBullets[titledIndex].bullets),
                          );
                        }),
                      if (sectionNumberedBullets.isNotEmpty)
                        ...List.generate(sectionNumberedBullets.length,
                            (numberedIndex) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: buildNumberedBullets(
                                index: numberedIndex + 1,
                                title:
                                    sectionNumberedBullets[numberedIndex].title,
                                bullets: sectionNumberedBullets[numberedIndex]
                                    .bullets),
                          );
                        }),
                      if (sectionMiscFact.isNotEmpty)
                        ...List.generate(
                          sectionMiscFact.length,
                          (miscFactIndex) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: buildMiscFact(
                                  misc: sectionMiscFact[miscFactIndex].misc,
                                  fact: sectionMiscFact[miscFactIndex].fact),
                            );
                          },
                        ),
                      if (sectionEnding.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: Text(
                            sectionEnding,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontFamily: 'RadioCanada',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      )
                    ],
                  ),
                );
              }))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBulletPoint({required String title, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'RadioCanada',
              fontSize: 12,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '• $title ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: text),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitledBullets(
      {required String section, required List<String> bullets}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section,
              style: const TextStyle(
                  fontFamily: 'RadioCanada',
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              bullets.length,
              (index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'RadioCanada',
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        bullets[index],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontFamily: 'RadioCanada',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ));
  }

  Widget buildNumberedBullets(
      {required int index,
      required String title,
      required List<String> bullets}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$index. $title",
                style: const TextStyle(
                    fontFamily: 'RadioCanada',
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ...List.generate(
              bullets.length,
              (index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        fontFamily: 'RadioCanada',
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        bullets[index],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: 'RadioCanada',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ));
  }

  Widget buildMiscFact(
      {required List<String> misc, required List<String> fact}) {
    int maxLength = misc.length > fact.length ? misc.length : fact.length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(maxLength, (index) {
          String miscText = index < misc.length ? misc[index] : '';
          String factText = index < fact.length ? fact[index] : '';

          return Visibility(
            visible: miscText.isNotEmpty || factText.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (miscText.isNotEmpty)
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'RadioCanada',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Misconception: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: miscText),
                      ],
                    ),
                  ),
                const SizedBox(height: 2),
                if (factText.isNotEmpty)
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'RadioCanada',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Fact: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: factText),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          );
        }),
      ),
    );
  }
}

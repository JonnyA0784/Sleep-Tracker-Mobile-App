import 'dart:core';

import 'package:units/dreams/utils/dreams_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class SleepVideos extends StatefulWidget {
  @override
  _SleepVideos createState() => _SleepVideos();
}

class _SleepVideos extends State<SleepVideos> {
  @override
  List<String> breathingTech = [
    'https://www.youtube.com/watch?v=4wEDoKm40Yc',
    'https://www.youtube.com/watch?v=j-1n3KJR1I8',
    'https://www.youtube.com/watch?v=bvdzTs0m510',
    'https://www.youtube.com/watch?v=bF_1ZiFta-E'
  ];
  List<String> breathingTechTitles = [
    'Equal Breathing For Sleep',
    'Breathing to Fall Asleep Fast',
    '5 Minutes of Breathing',
    'The Square Breathing Method'
  ];
  List<String> nightRoutine = [
    'https://www.youtube.com/watch?v=lgEMDJBvx8A',
    'https://www.youtube.com/watch?v=gDNDlPejKr4',
    'https://www.youtube.com/watch?v=LQ8JOsc3-wU',
    ''
  ];
  List<String> nightRoutineTitles = [
    'Perfect Skincare',
    'A Perfect Night Routine',
    'A Perfect Morning Routine',
    'Holder'
  ];
  List<String> sleepImprovement = [
    'https://www.youtube.com/watch?v=iMfsa7ntJZE',
    'https://www.youtube.com/watch?v=P_i6yqWjASk',
    'https://www.youtube.com/watch?v=y2rpKNU7Oyw',
    'https://www.youtube.com/watch?v=aaYys7uGqZQ'
  ];
  List<String> sleepImprovementTitles = [
    'Fix Your Sleep Schedule, Part 1',
    'Fix Your Sleep Schedule, Part 2',
    'Fix Your Nightly Routine Mistakes',
    'A Surgeons Guide to Perfect Sleep Secrets'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Informational Videos', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
        backgroundColor: ColorSelect.appBarBlue,
        iconTheme: IconThemeData(color: ColorSelect.lightBlue),
      ),
      /* just moved the bottomNav and menu bar to their own functions
        so they weren't taking up space in all of the view files */
      drawer: getMenuBar(context),
      bottomNavigationBar: getBottomNav(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 412,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sleepAppImage2.jpg"),
              //fit: BoxFit.fill,
              fit: BoxFit.fill,
            ),
          ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Browse informational video categories \nbelow to help you sleep',
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.,
                        style: TextStyle(
                          color: ColorSelect.lightBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      child: Text('Breathing Guides', style: TextStyle(color: ColorSelect.lightBlue, fontSize: 15),),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return BuildVideoPage(
                                  breathingTech,
                                  breathingTechTitles,
                                  'Breathing Guides To Help Master The Art of Falling Asleep',
                                  'Browse The Following Videos to \nImprove Your Breathing');
                            }));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: ColorSelect.backgroundBlue),
                    ),
      ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      child: Text('Nightly Routine Tips', style: TextStyle(color: ColorSelect.lightBlue, fontSize: 15),),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return BuildVideoPage(
                                  nightRoutine,
                                  nightRoutineTitles,
                                  'Informational Videos For Building a Nightly Routine',
                                  'Browse The Following Videos to \nCreate a Perfect Routine');
                            }));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: ColorSelect.backgroundBlue),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      child: Text('Getting Your Sleep Under Control', style: TextStyle(color: ColorSelect.lightBlue, fontSize: 15),),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return BuildVideoPage(
                                  sleepImprovement,
                                  sleepImprovementTitles,
                                  'Informational Videos For Getting Control of Your Sleep',
                                  'Browse Videos to Tackle Your Sleep');
                            }));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: ColorSelect.backgroundBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      );
    //);
  }

  Widget BuildVideoPage(
      List links, List titles, String pageTitle, String pageWording) {
    List videoLinks = links;
    List videoTitles = titles;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Informational Videos', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
        backgroundColor: ColorSelect.appBarBlue,
        iconTheme: IconThemeData(color: ColorSelect.lightBlue),
      ),
      drawer: getMenuBar(context),
      bottomNavigationBar: getBottomNav(context),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sleepAppImage2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pageWording,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: ColorSelect.lightBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(videoTitles[0], videoLinks[0]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(videoTitles[1], videoLinks[1]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(videoTitles[2], videoLinks[2]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(videoTitles[3], videoLinks[3]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, String url) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () =>
            launchUrlString(url, mode: LaunchMode.externalApplication),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorSelect.backgroundBlue,
        ),
        child: Text(text,
            style: TextStyle(
              color: ColorSelect.lightBlue,
            )),
      ),
    );
  }
}
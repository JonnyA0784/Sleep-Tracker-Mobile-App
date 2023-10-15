import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:units/dreams/utils/dreams_constant.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../../main.dart';
import '../views/DailyDiary.dart';
import '../views/ScreenTime.dart';
import '../views/SleepLog.dart';
import '../views/SleepNoise.dart';
import '../views/SleepVideos.dart';
import '../views/TipScreen.dart';
import '../views/colors.dart';

List<dynamic> calculator(double hour, double minute, double sleepHour, double sleepMinute, UnitType uniType, UnitType unitTypeTime) {

  List result = new List.filled(3, null, growable: false);
  double tempHour = 0.0;
  double tempMinute = 0.00;

  if(uniType == UnitType.BED) {
    tempHour = hour + sleepHour;
    tempMinute = minute + sleepMinute;

    if (tempMinute >= 60) {
      tempMinute -= 60;
      tempHour += 1;
    }
  }
  if (uniType == UnitType.WAKE) {
    tempHour = hour - sleepHour;
    tempMinute = minute - sleepMinute;

    if(tempMinute < 0){
      tempMinute += 60.00;
      tempHour -= 1;
    }
  }

  if(tempHour > 12 || tempHour < 0) {
    switch(unitTypeTime) {
      case UnitType.AM: { unitTypeTime = UnitType.PM; }
      break;
      case UnitType.PM: { unitTypeTime = UnitType.AM; }
      break;
      default: {}
      break;
    }

    tempHour %= 12;
  }
  if(tempHour ==0){
    tempHour = 12;
  }

  //result = tempHour + (tempMinute/100);
  result[0] = (tempHour + (tempMinute/100));
  result[1] = unitTypeTime;
  result[2] = uniType;
  return result;
}

bool isEmptyString(String string){
  return string == null || string.length == 0;
}

Future<int> loadValue() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int? data = preferences.getInt('data');
  if( data != null ) {
    return data;
  } else {
    return 0;
  }

}

void saveValue(int value) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('data', value);
}

//Menu bar code
Drawer getMenuBar(BuildContext context) {
  return Drawer(
    child: Container (
      color: ColorSelect.appBarBlue,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
                child: Text(
                    'M E N U',
                    style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 35, color: ColorSelect.lightBlue),)
                )),
          ),
          ListTile(
            leading: Icon(Icons.home),
            iconColor: ColorSelect.lightBlue,
            title: Text(
                'Home Page',
                style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 20, color: ColorSelect.lightBlue),)
            ),
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return MyApp();
              }));
            },
          ),
          ListTile(
            leading: Icon(IconData(0xe0bf, fontFamily: 'MaterialIcons')),
            iconColor: ColorSelect.lightBlue,
            title: Text(
                'Daily Diary',
                style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 20, color: ColorSelect.lightBlue),)
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (
                      BuildContext context) {
                    return DailyDiary();
                  }));
            },
          ),
          ListTile(
            leading: Icon(Icons.nights_stay),
            iconColor: ColorSelect.lightBlue,
            title: Text(
                'Sleep Tips',
                style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 20, color: ColorSelect.lightBlue),)
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (
                          BuildContext context) {
                        return TipScreen();
                      }));
            },
          ),
          ListTile(
            leading: Icon(IconData(0xe0bf, fontFamily: 'MaterialIcons')),
            iconColor: ColorSelect.lightBlue,
            title: Text(
                'Sleep Log',
                style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 20, color: ColorSelect.lightBlue),)
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (
                      BuildContext context) {
                    return SleepDiaryPage();
                  }));
            },
          ),
          ListTile(
            leading: Icon(Icons.music_note),
            iconColor: ColorSelect.lightBlue,
            title: Text(
                'Music & Sounds',
                style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 20, color: ColorSelect.lightBlue),)
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (
                      BuildContext context) {
                    return SleepNoise();
                  }));
            },
          ),
          ListTile(
            leading: Icon(Icons.ondemand_video_outlined),
            iconColor: ColorSelect.lightBlue,
            title: Text(
                'Informational Videos',
                style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 20, color: ColorSelect.lightBlue),)
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SleepVideos();
                  }));
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate_rounded),
            iconColor: ColorSelect.lightBlue,
            title: Text(
                'Sleep Calculator',
                style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 20, color: ColorSelect.lightBlue),)
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SplashScreen();
                  }));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_lock_portrait),
            iconColor: ColorSelect.lightBlue,
            title: Text(
                'Screen Time',
                style: GoogleFonts.dynaPuff(textStyle: TextStyle(fontSize: 20, color: ColorSelect.lightBlue),)
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ScreenTimePage();
                  }));
            },
          ),
        ],
      ),
    ),
  );
}
//bottom nav code
Container getBottomNav(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      color: ColorSelect.backgroundBlue,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 10),
      child: GNav(
        selectedIndex: 9,
        color: ColorSelect.lightBlue,
        activeColor: ColorSelect.backgroundBlue,
        tabBackgroundColor: ColorSelect.lightBlue,
        backgroundColor: ColorSelect.backgroundBlue,
        padding: EdgeInsets.all(16),
        gap: 8,
        onTabChange: (index) {
          print(index);
        },
        tabs: [
          GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return MyApp();
                }));
              }
          ),
          GButton(
            icon: Icons.calculate_rounded,
            text: 'Calculator',
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return SplashScreen();
              }));
            },
          ),
          GButton(
            icon: Icons.screen_lock_portrait,
            text: 'Screen time',
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return ScreenTimePage();
              }));
            },

          ),

        ],
      ),
    ),
  );
}
class Note {
  int caffeineIntake;
  String foodNotes;
  int stressValue;
  String date;

  Note({
    required this.caffeineIntake,
    required this.foodNotes,
    required this.stressValue,
    required this.date,
  });
}
Future<String> getStatsAvg(String stat) async {
  String message = " ";
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection('dailyDiary').get();
  List<Note> notesList = querySnapshot.docs.map((doc) {
    return Note(
      caffeineIntake: doc['caffeineIntake'],
      foodNotes: doc['foodNotes'],
      stressValue: doc['stressRating'],
      date: doc.id,
    );
  }).toList();


  if(stat == "stress") {
    double sum = 0;
    for (int i = 0; i < notesList.length; i++) {
      sum += notesList[i].stressValue;
    }
    String avgStress = (sum / notesList.length).toStringAsFixed(2);
    message = "Average Stress Rating: " + avgStress + "/10";
  }
  else if(stat == "caffeine"){
    double sumCaffeineIntake = 0;
    for (int i = 0; i < notesList.length; i++) {
      sumCaffeineIntake += notesList[i].caffeineIntake;
    }
    String avgCaff = (sumCaffeineIntake/notesList.length).toStringAsFixed(2);
    message = "Average Caffeine Intake: " + avgCaff +"mg";
  }
  return message;
}


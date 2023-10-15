import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:units/dreams/utils/dreams_utils.dart';
import 'package:units/dreams/views/IndividualizedScreenTime.dart';
import 'package:units/dreams/views/TipScreen.dart';
import 'package:units/dreams/views/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../main.dart';
import 'package:units/dreams/views/ScreenTime.dart';
import 'package:units/dreams/views/DailyDiary.dart';
import 'package:units/dreams/views/ScreenTime.dart';
import 'package:units/dreams/views/SleepLog.dart';
import 'package:units/dreams/views/SleepNoise.dart';
import 'package:units/dreams/views/SleepVideos.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenTimePage extends StatefulWidget {
  @override
  _ScreenTimePageState createState() => _ScreenTimePageState();
}

class _ScreenTimePageState extends State<ScreenTimePage> {
  final _formKey = GlobalKey<FormState>();
  String time = '';
  ListView stats = ListView();
  String convertMinutesToHours(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '$hours hours and $remainingMinutes minutes';
  }
  int _screenTimeMinutes = 0;
  List<AppUsageInfo> _usageList = [];
  @override
  void initState() {
    super.initState();
    getUsageStats();
  }
  String getScreenTime(List<AppUsageInfo> usageList) {
    if (usageList.isEmpty) {
      return 'No usage data available';
    } else {
      final totalUsageInMinutes = usageList.map((e) => e.usage.inMinutes).reduce((a, b) => a + b);
      final hours = totalUsageInMinutes ~/ 60;
      final minutes = totalUsageInMinutes % 60;
      return 'Total screen time: $hours h $minutes m';
    }
  }

  void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 1));
      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(startDate, endDate);

      //filter out un-needed app time so stats are more accurate
     // infoList = infoList.where((info) => info.packageName != "com.android.settings").toList();
      //infoList = infoList.where((info) => info.appName != "SweetDreams").toList();
      //infoList = infoList.where((info) => info.appName != "nexuslauncher").toList();
      setState(() {
        _usageList = infoList;
      });

    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.appBarBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Daily Screen Time', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
        iconTheme: IconThemeData(color: ColorSelect.lightBlue),
        backgroundColor: ColorSelect.appBarBlue,
        actions: [
        ],
      ),
      drawer: getMenuBar(context),
      bottomNavigationBar: getBottomNav(context),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sleepAppImage2.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0,175,16,100),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: ColorSelect.backgroundBlue,
                boxShadow: [
                  BoxShadow(
                    color: ColorSelect.black,
                    blurRadius: 5.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image(
                        image: AssetImage('assets/images/NoBackgroundKevin.png'),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Your Screen Time Today',
                        style: TextStyle(
                          color: ColorSelect.lightBlue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${_usageList.length == 0 ? 'No usage data available' : 'Total screen time: ${_usageList.map((stat) => stat.usage.inMinutes).reduce((a, b) => a + b) ~/ 60}h ${_usageList.map((stat) => stat.usage.inMinutes).reduce((a, b) => a + b) % 60}m'}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorSelect.lightBlue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                              return AppScreenTime();
                            }));

                          }, child: Text('See individualized app time', style: TextStyle(color: ColorSelect.lightBlue),),
                        style: ElevatedButton.styleFrom(
                          //add style to button here
                          backgroundColor: ColorSelect.appBarBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }


}
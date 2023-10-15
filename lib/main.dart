import 'dart:math';
import 'package:flutter/material.dart';
import 'package:units/dreams/views/DailyDiary.dart';
import 'package:units/dreams/views/ScreenTime.dart';
import 'package:units/dreams/views/SleepLog.dart';
import 'package:units/dreams/views/SleepNoise.dart';
import 'dreams/views/SleepVideos.dart';
import 'dreams/views/colors.dart';
import 'dreams/views/dreams_component.dart';
import 'dreams/views/TipScreen.dart';
import 'dreams/presenter/dreams_presenter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native_notify/native_notify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // can call this instead of using FutureBuilder to initialize Firebase
  await Firebase.initializeApp();
  NativeNotify.initialize(2882, '7cXHkXb03ik5SjGQ1N4Ewl', null, 'resource://drawable/notification_icon');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: ColorSelect.backgroundBlue,
        home: Builder(
            builder: (context) =>
                Scaffold(
                  backgroundColor: ColorSelect.backgroundBlue,
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        centerTitle: true,
                        title: Text("Sweet Dreams", style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
                        backgroundColor: ColorSelect.appBarBlue,
                      ),
                      SliverAppBar(
                        backgroundColor: ColorSelect.backgroundBlue,
                        elevation: 0,
                        pinned: true,
                        centerTitle: false,
                        expandedHeight: 275.0,
                        stretch: true,
                        flexibleSpace: const FlexibleSpaceBar(
                          stretchModes: [
                            StretchMode.zoomBackground,
                          ],
                          background: Image(
                            image: AssetImage('assets/images/NoBackgroundKevin.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10, right: 10),

                                child: Column(
                                  children: <Widget>[

                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorSelect.lightBlue,
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                            width: 2.0, color: ColorSelect.black),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(IconData(0xe0bf, fontFamily: 'MaterialIcons')),
                                            iconColor: ColorSelect.appBarBlue,
                                            title: Text('Daily Diary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ColorSelect.appBarBlue),),
                                            subtitle: Text(
                                              'Track your daily behaviors here', style: TextStyle(color: ColorSelect.appBarBlue),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              TextButton(
                                                child: Text('Go to page', style: TextStyle(color: ColorSelect.appBarBlue),),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (
                                                          BuildContext context) {
                                                        return DailyDiary();
                                                      }));
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10, right: 10),),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: ColorSelect.lightBlue,
                                        border: Border.all(
                                            width: 2.0, color: ColorSelect.black),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.nights_stay),
                                            iconColor: ColorSelect.appBarBlue,
                                            title: Text('Sleep Tips', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ColorSelect.appBarBlue),),
                                            subtitle: Text(
                                              'Tips to Promote Healthy Sleep Habits', style: TextStyle(color: ColorSelect.appBarBlue),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              TextButton(
                                                child: Text('Go to page', style: TextStyle(color: ColorSelect.appBarBlue),),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (
                                                              BuildContext context) {
                                                            return TipScreen();
                                                          }));
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10, right: 10),),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: ColorSelect.lightBlue,
                                        border: Border.all(
                                            width: 2.0, color: ColorSelect.black),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(IconData(0xe0bf, fontFamily: 'MaterialIcons')),
                                            iconColor: ColorSelect.appBarBlue,
                                            title: Text('Sleep Log', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ColorSelect.appBarBlue),),
                                            subtitle: Text(
                                              'Track when you went to bed and got up', style: TextStyle(color: ColorSelect.appBarBlue),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              TextButton(
                                                child: Text('Go to page', style: TextStyle(color: ColorSelect.appBarBlue),),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (
                                                          BuildContext context) {
                                                        return SleepDiaryPage();
                                                      }));
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10, right: 10),),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: ColorSelect.lightBlue,
                                        border: Border.all(
                                            width: 2.0, color: ColorSelect.black),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.music_note),
                                            iconColor: ColorSelect.appBarBlue,
                                            title: Text('Music & Sounds', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ColorSelect.appBarBlue),),
                                            subtitle: Text(
                                              'Soothing Soundscapes to Help You Fall Asleep', style: TextStyle(color: ColorSelect.appBarBlue),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              TextButton(
                                                child: Text('Go to page', style: TextStyle(color: ColorSelect.appBarBlue),),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (
                                                          BuildContext context) {
                                                        return SleepNoise();
                                                      }));
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10, right: 10),),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: ColorSelect.lightBlue,
                                        border: Border.all(
                                            width: 2.0, color: ColorSelect.black),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.ondemand_video_outlined),
                                            iconColor: ColorSelect.appBarBlue,
                                            title: Text('Informational Videos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ColorSelect.appBarBlue),),
                                            subtitle: Text(
                                              'A variety of videos to improve your sleep habits', style: TextStyle(color: ColorSelect.appBarBlue),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              TextButton(
                                                child: Text('Go to page', style: TextStyle(color: ColorSelect.appBarBlue),),
                                                onPressed: () {
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                                    return SleepVideos();
                                                  }));
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                )
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ],
                  ),

                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20),
                    child: GNav(
                      selectedIndex: 0,
                      color: ColorSelect.lightBlue,
                      activeColor: ColorSelect.appBarBlue,
                      tabBackgroundColor: ColorSelect.lightBlue,
                      padding: EdgeInsets.all(16),
                      gap: 8,
                      onTabChange: (index) {
                        print(index);
                      },
                      tabs: [
                        GButton(
                          icon: Icons.home,
                          text: 'Home',
                        ),
                        GButton(
                          icon: Icons.calculate_rounded,
                          text: 'Calculator',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return SplashScreen();
                                }));
                          },
                        ),
                        GButton(
                          icon: Icons.screen_lock_portrait,
                          text: 'Screen time',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return ScreenTimePage();
                                }));
                          },
                        ),
                      ],
                    ),
                  ),
                )
        )
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new HomePage(new BasicPresenter(), title: 'Sweet Dreams', key: Key("UNITS"),);
  }
}
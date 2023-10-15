import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:units/dreams/utils/dreams_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TipScreen extends StatefulWidget{
  @override
  _TipScreen createState() => _TipScreen();
}



class _TipScreen extends State<TipScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tips for Good Sleep', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
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
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton('Best Diet Tips To Promote Good Sleep', 'https://www.sleepfoundation.org/nutrition/food-and-drink-promote-good-nights-sleep'),
                _buildButton('Best Night Routines Before Going To Bed', 'https://www.sleepfoundation.org/sleep-hygiene/bedtime-routine-for-adults'),
                _buildButton('Tips For Fixing Your Sleep Schedule', 'https://www.sleepfoundation.org/sleep-hygiene/how-to-reset-your-sleep-routine'),
                _buildButton('Info on Melatonin Dosage', 'https://www.sleepfoundation.org/melatonin/melatonin-dosage-how-much-should-you-take'),
                _buildButton('Tips if You Have Insomnia', 'https://www.sleepfoundation.org/insomnia/treatment/what-do-when-you-cant-sleep'),
                _buildButton('3 Hour Guided Sleep Meditation', 'https://www.youtube.com/watch?v=ZKMb0tH5qs8'),
                ListTile(
                  leading: Icon(Icons.add_alert_sharp, color: ColorSelect.lightBlue,),
                  title: Text('Daily Sleep Tips',style: TextStyle(color: ColorSelect.lightBlue, fontWeight: FontWeight.bold)),
                  subtitle: Text(getRandTip(),style: TextStyle(color: ColorSelect.lightBlue),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text('Get New Tip', style: TextStyle(color: Color(0xFFBBDEFB), fontWeight: FontWeight.bold, fontSize: 16, ),),
                      onPressed: () {
                          setState(() {

                          });
                      },
                      style: ElevatedButton.styleFrom(
                        //add style to button here
                        backgroundColor: ColorSelect.backgroundBlue,
                      ),
                    ),
                   /* FloatingActionButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:  Text(getRandTip()),
                            action: SnackBarAction(
                              label: 'New Tip',
                              onPressed: () {

                              },
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.add_alert_sharp, color: Colors.white,),
                    )*/



                    const SizedBox(width: 8),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }


  // Define a function to create multiple buttons
  Widget _buildButton(String text, String url) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () => launchUrlString(url, mode: LaunchMode.externalApplication ),
        style: ElevatedButton.styleFrom(
          //add style to button here
          backgroundColor: ColorSelect.backgroundBlue,
        ),
        child: Text(text, style: TextStyle(color: Color(0xFFBBDEFB)),),
      ),
    );
  }
  final List<String> sleepTips = [
    'Establish a regular sleep routine and stick to it',
    'Create a relaxing bedtime ritual to wind down before sleep',
    'Keep your bedroom cool, dark, and quiet',
    'Invest in a comfortable mattress and pillows',
    'Avoid eating heavy meals before bed',
    'Limit caffeine intake, especially in the afternoon and evening',
    'Exercise regularly, but not too close to bedtime',
    'Don’t nap too much during the day',
    'Avoid using electronic devices before bed',
    'Reduce your exposure to bright light in the evening',
    'Practice stress-reduction techniques such as meditation or yoga',
    'Listen to calming music or white noise to help you sleep',
    'Use aromatherapy with calming scents such as lavender',
    'Avoid consuming fluids close to bedtime to reduce the need to urinate',
    'Don’t watch TV or work in bed',
    'Reserve your bed for sleeping and sex only',
    'Make sure your bedroom is comfortable and conducive to sleep',
    'Don’t watch the clock at night',
    'Keep a sleep diary to track your sleep habits',
    'Don’t lie in bed awake for too long',
    'Try relaxation techniques such as deep breathing or progressive muscle relaxation',
    'Limit your exposure to stimulating activities before bed',
    'Take a warm bath or shower before bed',
    'Create a comfortable sleep environment with comfortable bedding',
    'Use blackout curtains to eliminate light from outside',
    'Practice good sleep hygiene by keeping a regular sleep schedule',
    'Get plenty of natural light during the day',
    'Avoid taking naps late in the day',
    'Drink chamomile tea before bed to promote relaxation',
    'Reduce your intake of sugary and fatty foods',
    'Avoid eating spicy or acidic foods close to bedtime',
    'Don’t consume caffeine or other stimulants before bed',
    'Avoid taking medications that can interfere with sleep',
    'Make sure your bed is the right size and height for you',
    'Invest in a comfortable pillow that supports your neck',
    'Use a sleep mask to block out light',
    'Get plenty of exercise during the day to promote good sleep',
    'Don’t drink too much alcohol before bed',
    'Keep a consistent sleep schedule even on weekends',
    'Use a humidifier to keep your bedroom air moist',
    'Practice positive self-talk before bed to reduce anxiety',
    'Don’t watch scary or disturbing movies before bed',
    'Use a comfortable and supportive mattress',
    'Create a calming sleep environment with soothing colors and decor',
    'Avoid stimulating conversations or arguments before bed',
    'Don’t work or study in bed',
    'Use white noise or calming sounds to help you sleep',
    'Try acupuncture or massage to promote relaxation and sleep'
  ];

  String getRandTip(){
    return sleepTips[Random().nextInt(sleepTips.length)];
  }
}

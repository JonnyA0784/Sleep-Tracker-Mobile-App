//import 'dart:html';
//import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:units/dreams/utils/dreams_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class SleepNoise extends StatefulWidget {
  @override
  _SleepNoise createState() => _SleepNoise();
}

class _SleepNoise extends State<SleepNoise> {
  @override
  Widget build(BuildContext context) {
    AudioPlayer advancedPlayer = AudioPlayer();
    AudioCache player = AudioCache(
      fixedPlayer: advancedPlayer,
      prefix: 'assets/audios/'
    );
    List<String> songs = [
      'Jul.mp3',
      'crashingWaves.mp3',
      'Crickets.mp3',
      'SoftRain.mp3',
      'sunsetHorizon.mp3'
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Music for Good Sleep', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
        backgroundColor: ColorSelect.appBarBlue,
        iconTheme: IconThemeData(color: ColorSelect.lightBlue),
      ),
      drawer: getMenuBar(context),
      bottomNavigationBar: getBottomNav(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
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
              ListTile(
                //leading: Icon(Icons.music_note, color: ColorSelect.lightBlue,),
                title: Text('   \nChoose from any sounds below.',style: TextStyle(color: ColorSelect.lightBlue, fontWeight: FontWeight.bold, fontSize: 20)),
                leading: Icon(Icons.music_note, color: ColorSelect.lightBlue,),
                subtitle: Text('Shuffle, loop, or play individually to best cater to your sleep needs.',style: TextStyle(color: ColorSelect.lightBlue),),
              ),

              _soundBuildButton('Cabin Sounds', 'Jul.mp3', player),
              _soundBuildButton('Daydreaming By The Ocean', 'crashingWaves.mp3', player),
              _soundBuildButton('Crickets', 'Crickets.mp3', player),
              _soundBuildButton('Rain Against The Roof', 'SoftRain.mp3', player),
              _soundBuildButton('Cabin Sounds', 'sunsetHorizons.mp3', player),
              _buildButton('10-Hour Sleep Mix on Youtube', 'https://www.youtube.com/watch?v=Pq-5vTJk38k'),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  playButton(player),
                  pauseButton(player),
                  _ShuffleButton(songs, player)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _soundBuildButton(String text, String filename, AudioCache player) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          if(player.fixedPlayer?.state == PlayerState.PLAYING){
            player.fixedPlayer?.stop();
          }
          player.play(filename);
        },
        style: ElevatedButton.styleFrom(
          //add style to button here
          backgroundColor: ColorSelect.backgroundBlue,
        ),
        child: Text(text, style: TextStyle(color: Color(0xFFBBDEFB)),),
      ),
    );
  }
  IconButton pauseButton(AudioCache player){
    return IconButton(
    icon: Icon(Icons.pause),
    color: ColorSelect.lightBlue,
    onPressed: () async {
      if(player.fixedPlayer?.state == PlayerState.PLAYING){
        player.fixedPlayer?.pause();
      }
    });
  }
  IconButton playButton(AudioCache player){
    return IconButton(
        icon: Icon(Icons.play_arrow),
        color: ColorSelect.lightBlue,
        onPressed: () async {
          if(player.fixedPlayer?.state == PlayerState.PAUSED){
            player.fixedPlayer?.resume();
          }
        });
  }
  IconButton _ShuffleButton(List<String> songs, AudioCache player) {
    return IconButton(
        icon: Icon(Icons.shuffle),
        color: ColorSelect.lightBlue,
        onPressed: () async {
          //List<String> shuffledSongs = songShuffler(songs);
          List<String> shuffledSongs = songShuffler(songs);
          if(player.fixedPlayer?.state == PlayerState.PLAYING){
            player.fixedPlayer?.stop();
          }
          for(int i = 0; i < shuffledSongs.length; i++){
            String file = shuffledSongs[i];
            player = (await player.play(file)) as AudioCache;
            while(player.fixedPlayer?.state == PlayerState.PLAYING){
              print("while: ${player.fixedPlayer?.state}");
              await Future.delayed(Duration(seconds: 1));
              print(i);
              if(player.fixedPlayer?.state == PlayerState.PLAYING){
                player.fixedPlayer?.onPlayerCompletion.listen((onDone) async {
                  print("object");
                  player.clear(file as Uri);
                  player.fixedPlayer?.state = PlayerState.COMPLETED;
                  await player.fixedPlayer?.stop();
                });
              }
              if(player.fixedPlayer?.state == PlayerState.COMPLETED){
                print("if: ${player.fixedPlayer?.state}");
                await player.fixedPlayer?.stop();
                break;
              }
            }

          }
        });
  }
  List<String> songShuffler(List<String> list) {
    var L = list;
    L.shuffle();
    return L;
  }
}

// Define a function to create multiple buttons
Widget _buildButton(String text, String url) {
  return SizedBox(
    width: 300,
    child: ElevatedButton(
      onPressed: () =>
          launchUrlString(url, mode: LaunchMode.externalApplication),
      style: ElevatedButton.styleFrom(
        //add style to button here
        backgroundColor: ColorSelect.backgroundBlue,
      ),
      child: Text(text, style: TextStyle(color: ColorSelect.lightBlue),),
    ),
  );
}

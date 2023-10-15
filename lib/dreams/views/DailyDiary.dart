import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:units/dreams/utils/dreams_utils.dart';
import 'package:units/dreams/views/chartTest.dart';
import 'package:units/dreams/views/colors.dart';
import 'package:google_fonts/google_fonts.dart';


class DailyDiary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DailyDiary();
}


class _DailyDiary extends State<DailyDiary> {
  final _formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseFirestore.instance.collection('dailyDiary');
  double stressValue = 5.0;
  String foodNotes =  '';
  String stressNotes= '';
  String date = DateFormat('MM-dd-yyyy').format(DateTime.now());
  List<Note> _notesList = [];
  int caffAmount = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Daily Diary', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
        backgroundColor: ColorSelect.appBarBlue,
        iconTheme: IconThemeData(color: ColorSelect.lightBlue),
      ),
      drawer: getMenuBar(context),
      bottomNavigationBar: getBottomNav(context),
      body: Stack(
        children: [
          Container(
            //color: Colors.lightBlue[50],
            //color: ColorSelect.backgroundBlue,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sleepAppImage2.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 2),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.center,
                        child:Icon(IconData(0xe0bf, fontFamily: 'MaterialIcons'), size: 150, color: ColorSelect.lightBlue,),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: ColorSelect.lightBlue,
                          border: Border.all(color: ColorSelect.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SizedBox(
                          height: 150,
                          child: CupertinoDatePicker(
                            backgroundColor: ColorSelect.lightBlue,
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (dateTime){
                              date = DateFormat('MM-dd-yyyy').format(dateTime);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: ColorSelect.lightBlue,
                          border: Border.all(color: ColorSelect.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          style: TextStyle(
                              color: ColorSelect.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Caffeine Consumption',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (String notesC) {
                            caffAmount = int.parse(notesC);

                          },
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: ColorSelect.lightBlue,
                          border: Border.all(color: ColorSelect.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          style: TextStyle(
                              color: ColorSelect.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Food Notes',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (String notesF) {
                            foodNotes = notesF;
                          },
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: ColorSelect.lightBlue,
                          border: Border.all(color: ColorSelect.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text('Rate your stress levels from 0-10:'),
                            Slider(
                              activeColor: ColorSelect.black,
                              inactiveColor: ColorSelect.black,
                              value: stressValue,
                              min: 0,
                              max: 10,
                              divisions: 10,
                              label: _getSleepQualityLabel(),
                              onChanged: (value) {
                                setState(() {
                                  stressValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () async {
                            stressNotes = _getSleepQualityLabel();
                            databaseReference.doc(date).set({"caffeineIntake": caffAmount, "foodNotes": foodNotes, "stressRating": stressValue.toInt(),});
                            _showSavedMessage(context);
                          }, child: Text('Save', style: TextStyle(color: ColorSelect.lightBlue),),
                            style: ElevatedButton.styleFrom(
                              //add style to button here
                              backgroundColor: ColorSelect.appBarBlue,
                            ),
                          ),
                          SizedBox(width: 10,),
                          ElevatedButton(onPressed: (){
                            displayData();
                          }, child: Text('See Entries Here', style: TextStyle(color: ColorSelect.lightBlue),),
                            style: ElevatedButton.styleFrom(
                            //add style to button here
                            backgroundColor: ColorSelect.appBarBlue,
                            )
                          ),
                          SizedBox(width: 10,),
                          ElevatedButton(onPressed: () async {
                            displayCaffData();
                          }, child: Text('See Stats Here', style: TextStyle(color: ColorSelect.lightBlue),),
                              style: ElevatedButton.styleFrom(
                                //add style to button here
                                backgroundColor: ColorSelect.appBarBlue,
                              )
                          ),
                        ],
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

  String _getSleepQualityLabel() {
    switch (stressValue.toInt()) {
      case 0:
        return '0/10';
      case 1:
        return '1/10';
      case 2:
        return '2/10';
      case 3:
        return '3/10';
      case 4:
        return '4/10';
      case 5:
        return '5/10';
      case 6:
        return '6/10';
      case 7:
        return '7/10';
      case 8:
        return '8/10';
      case 9:
        return '9/10';
      case 10:
        return '10/10';
      default:
        return '';
    }
  }


  void _showSavedMessage(BuildContext context){
    final saveLabel = SnackBar(content: Text('Entry Saved'), duration: Duration(seconds: 3),);
    ScaffoldMessenger.of(context).showSnackBar(saveLabel);
  }


  void displayData() async {
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
    setState(() {
      _notesList = notesList;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorSelect.backgroundBlue,
          title: Text("Daily Diary Entries", style: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: _notesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: ColorSelect.lightBlue,
                  child: ListTile(
                    title: Text("${_notesList[index].date}", style: TextStyle(color: ColorSelect.appBarBlue, fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Caffeine Intake: ${_notesList[index].caffeineIntake}" + "mg", style: TextStyle(color: ColorSelect.appBarBlue),),
                        Text("Food Notes: ${_notesList[index].foodNotes}", style: TextStyle(color: ColorSelect.appBarBlue),),
                        Text("Stress Rating: ${_notesList[index].stressValue}" + "/10", style: TextStyle(color: ColorSelect.appBarBlue),),
                        FloatingActionButton(
                          backgroundColor: ColorSelect.backgroundBlue,
                          onPressed: (){
                            databaseReference.doc(_notesList[index].date).delete();
                            setState(() {
                              //update card screen
                            });
                          },
                          child: Icon(Icons.delete, color: ColorSelect.lightBlue,),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: ColorSelect.appBarBlue),
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close", style: TextStyle(color: ColorSelect.lightBlue),),
            ),
          ],
        );
      },
    );
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

  //very similar to displaying the database entries except
  void displayCaffData() async {
    String message = " ";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: ColorSelect.backgroundBlue,
            title: Text("Daily Diary Entries", style: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/NoBackgroundKevin.png'),
                      fit: BoxFit.cover,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: ColorSelect.appBarBlue),
                          onPressed: () async {
                            String avgCaff = await getStatsAvg("caffeine");
                            setState(() {
                              message = avgCaff;
                            });
                          },
                          child: Text("Get Caffeine Avg", style: TextStyle(color: ColorSelect.lightBlue),),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: ColorSelect.appBarBlue),
                          onPressed: () async {
                            String avgStress = await getStatsAvg("stress");
                            setState(() {
                              message = avgStress;
                            });
                          },
                          child: Text("Get Stress Avg", style: TextStyle(color: ColorSelect.lightBlue),),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: ColorSelect.appBarBlue),
                          onPressed: ()  {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (
                                    BuildContext context) {
                                  return MyWidget();
                                }));
                          },
                          child: Text("Get Caffeine Graph", style: TextStyle(color: ColorSelect.lightBlue),),
                        ),
                      ],
                    ),
                    Text(message, style: TextStyle(color: ColorSelect.lightBlue, fontSize: 20),),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: ColorSelect.appBarBlue),
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Close", style: TextStyle(color: ColorSelect.lightBlue),),
              ),
            ],
          );
        });
      },
    );
  }



}
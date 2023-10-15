import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:flutter/src/material/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:units/dreams/utils/dreams_utils.dart';
import 'package:units/dreams/views/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class SleepDiaryPage extends StatefulWidget {
  @override
  _SleepDiaryPageState createState() => _SleepDiaryPageState();
}

class _SleepDiaryPageState extends State<SleepDiaryPage> {
  DateTime dateSelector = DateTime.now();
  int minutesSlept = 0;
  String timeSlept = '';
  String notes = '';
  double sleepQuality = 3;
  TimeOfDay _bedTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay  _wakeUpTime =TimeOfDay(hour: 0, minute: 0);
  final databaseReference = FirebaseFirestore.instance.collection('sleepDiary');
  final _formKey = GlobalKey<FormState>();
  List<ChartData> chartData = [];

  Color sleepQualityC = Colors.green;
  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sleep Log', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
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

                child: SingleChildScrollView(

                    padding: EdgeInsets.fromLTRB(16, 2, 16, 2),
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
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
                                        onDateTimeChanged: (dateTime) {
                                          dateSelector = dateTime;
                                        },
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    //padding: EdgeInsets.all(20.0),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 50),
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: ColorSelect.lightBlue,
                                              border: Border.all(color: ColorSelect.black),
                                              borderRadius: BorderRadius.circular(
                                                  10.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Text('How did you sleep?'),
                                                Slider(
                                                  activeColor: ColorSelect.black,
                                                  inactiveColor: ColorSelect.lightBlue,
                                                  value: sleepQuality,
                                                  min: 0,
                                                  max: 4,
                                                  divisions: 4,
                                                  label: _getSleepQualityLabel(sleepQuality.floor()),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      sleepQuality = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 25),
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: ColorSelect.lightBlue,
                                              border: Border.all(color: ColorSelect.black),
                                              borderRadius: BorderRadius.circular(
                                                  10.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Icon(Icons.access_time),
                                                SizedBox(width: 15),
                                                Text(
                                                    'What time did you go to bed?: '),
                                                TextButton(
                                                  onPressed: () {
                                                    _selectTime(context, true);
                                                  },
                                                  child: Text(
                                                    _bedTime == null
                                                        ? 'Select Time'
                                                        : _bedTime.format(context),
                                                    style: TextStyle(
                                                      color: ColorSelect.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 25),
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: ColorSelect.lightBlue,
                                              border: Border.all(color: ColorSelect.black),
                                              borderRadius: BorderRadius.circular(
                                                  10.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Icon(Icons.access_time),
                                                SizedBox(width: 15),
                                                Text('What time did you wake up?: '),
                                                TextButton(
                                                  onPressed: () {
                                                    _selectTime(context, false);
                                                  },
                                                  child: Text(
                                                    _wakeUpTime == null
                                                        ? 'Select Time'
                                                        : _wakeUpTime.format(context),
                                                    style: TextStyle(
                                                        color: ColorSelect.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 25),
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: ColorSelect.lightBlue,
                                              border: Border.all(color: ColorSelect.black),
                                              borderRadius: BorderRadius.circular(
                                                  10.0),
                                            ),
                                            child: TextField(
                                              style: TextStyle(
                                                  color: ColorSelect.black
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Write anything you\'d like about your night of sleep',
                                              ),
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              onChanged: ( label) {
                                                notes = label;
                                              },
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 25),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:ColorSelect.appBarBlue,

                                                ),
                                                onPressed: () {


                                                  DateTime DT_sleepTime = DateTime(dateSelector.year,dateSelector.month,dateSelector.day, _bedTime.hour,_bedTime.minute);
                                                  DateTime DT_wakeTime = DateTime(dateSelector.year, dateSelector.month,dateSelector.day+1,_wakeUpTime.hour,_wakeUpTime.minute);

                                                  Timestamp sleepTime = Timestamp.fromDate(DT_sleepTime);
                                                  Timestamp wakeTime = Timestamp.fromDate(DT_wakeTime);
                                                  addSleepEntry(sleepQuality.floor(),sleepTime , wakeTime, notes);
                                                },
                                                child: Text(
                                                  'Save',
                                                  style: TextStyle(
                                                    color: ColorSelect.lightBlue,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width:10),
                                              ElevatedButton(
                                                onPressed:(){
                                                  displayData();
                                                },

                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:ColorSelect.appBarBlue,
                                                ),
                                                child: Text("Submissions", style: TextStyle(color: ColorSelect.lightBlue),),

                                              ),
                                              SizedBox(width:15),
                                              ElevatedButton(
                                                onPressed: (){
                                                  displayStatistics();
                                                },
                                                child: Text("Statistics", style: TextStyle(color: ColorSelect.lightBlue),),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: ColorSelect.appBarBlue,
                                                ),
                                              )
                                            ],
                                          ),
                                        ]
                                    ),
                                  )
                                ]
                            ),


                          ),
                        )
                    )
                )
            )
        )
    );
  }



  Future<void> _selectTime(BuildContext context, bool isBedTime) async {
    final TimeOfDay initialTime = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: ColorSelect.backgroundBlue,
              ),
              colorScheme: ColorScheme.light(
                primary: ColorSelect.lightBlue, // <-- SEE HERE
                onPrimary: ColorSelect.appBarBlue, // <-- SEE HERE
                onSurface: ColorSelect.lightBlue, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorSelect.lightBlue, // button text color
                ),
              ),
            ), child: child!,
          );
        }
    );
    if (pickedTime != null) { // Add a null check
      setState(() {
        if (isBedTime) {
          _bedTime = pickedTime;

        } else {
          _wakeUpTime = pickedTime;
        }
      });
    }
  }

  void _showSavedMessage(BuildContext context){
    final saveLabel = SnackBar(content: Text('Entry Saved'), duration: Duration(seconds: 3),);
    ScaffoldMessenger.of(context).showSnackBar(saveLabel);
  }

  String _getSleepQualityLabel(int i) {
    switch (i) {
      case 0:
        return 'Terrible';
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Excellent';
      default:
        return 'NA';
    }
  }
  //adds an entry to the collection
  Future<void> addSleepEntry(int sleepQuality, Timestamp goingToSleepTime, Timestamp wakingUpTime, String notes) async {
    //final collection = FirebaseFirestore.instance.collection('sleep_records');
    final newDocRef = databaseReference.doc();

    await newDocRef.set({
      'sleepQuality': sleepQuality,
      'goingToSleepTime': goingToSleepTime,
      'wakingUpTime': wakingUpTime,
      'notes': notes,
    });
  }

  void displayData() async {
    int n = 10; // the number of database thinsg we want displayed

    final entries = await getMostRecentSleepRecords(n);

    n = min(n, entries.size);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorSelect.backgroundBlue,
          title: Text("Sleep Entries", style: TextStyle(color: ColorSelect.lightBlue, fontWeight: FontWeight.bold, fontSize: 25),),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: n,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: ColorSelect.lightBlue,
                  child: ListTile(
                    title: Text(DateFormat('MMM dd yyyy').format(entries.docs[index]['goingToSleepTime'].toDate()),style: TextStyle(color: ColorSelect.appBarBlue, fontSize: 18, fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("time slept: " + calculateTimeDifference(entries.docs[index]['goingToSleepTime'],entries.docs[index]['wakingUpTime']), style: TextStyle(color: ColorSelect.appBarBlue),),
                        Text("sleep quality: " + _getSleepQualityLabel(entries.docs[index]['sleepQuality']), style: TextStyle(color: ColorSelect.appBarBlue),),
                        Text("went to bed at: " + formatTimeOfDay(entries.docs[index]['goingToSleepTime']), style: TextStyle(color: ColorSelect.appBarBlue),),
                        Text("woke up at: " + formatTimeOfDay(entries.docs[index]['wakingUpTime']), style: TextStyle(color: ColorSelect.appBarBlue),),
                        Text("notes: " + entries.docs[index]['notes'], style: TextStyle(color: ColorSelect.appBarBlue),),
                        FloatingActionButton(
                          backgroundColor: ColorSelect.backgroundBlue,
                          onPressed: (){
                            DocumentReference docRef = entries.docs.elementAt(index).reference;
                            docRef.delete()
                                .then((value) => print("Document deleted successfully"))
                                .catchError((error) => print("Failed to delete document: $error"));
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

  //statistics stuff goes in here!!!!!!!

  void displayStatistics() async {
    int n = 30; // the number of database thinsg we want displayed

    final entries = await getMostRecentSleepRecords(n);

    n = min(n, entries.size);
    var array = [];


    // - - - - calculate average sleep quality and time slept over n days - - - - - -
    double sleepSum = 0;
    num qualitySum = 0;
    for(int i = 0; i < n; i++){
      qualitySum += entries.docs[i]['sleepQuality'];
      int x = calculateTimeDifferenceMinutes(entries.docs[i]['goingToSleepTime'],entries.docs[i]['wakingUpTime']);
      double y = (x/60);
      sleepSum += x;
      array.insert(i,y);
    }
    //display this for avg sleep quality
    String avgQualityString = _getSleepQualityLabel((qualitySum/n).floor());

    //display this for average time slept
    String sleepAvg = ((((sleepSum/n)/60).floor()).toString() + " hours and " + (((sleepSum/n)%60).floor()).toString() + " minutes");
    //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    chartData = [
      ChartData(1, array[0]),
      ChartData(2, array[1]),
      ChartData(3, array[2]),
      ChartData(4, array[3]),
      ChartData(5, array[4]),
      ChartData(6, array[5]),
      ChartData(7, array[6]),

    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorSelect.backgroundBlue,
            title: Text("Sleep Statistics in Past 30 Days", style: TextStyle(color: ColorSelect.lightBlue,fontSize: 25, fontWeight: FontWeight.bold)),
            content: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              child: Container(
                child: Column(
                    children: <Widget>[
                      Text('Average Sleep Quality',
                          style: TextStyle(
                            color: ColorSelect.lightBlue,
                              fontSize: 20
                          )),
                      SizedBox(height:15),
                      Text(avgQualityString,
                          style: TextStyle(
                            fontSize: 20,
                            color: sleepQualityColor(avgQualityString),
                          )),
                      SizedBox(height: 50),
                      Text('Average Sleep Amount:',
                          style: TextStyle(
                              color: ColorSelect.lightBlue,
                              fontSize: 20)),
                      SizedBox(height: 15),
                      Text(sleepAvg,
                      style: TextStyle(
                        color: ColorSelect.lightBlue,
                      )),
                      SizedBox(height:60),
                      Text('Last 30 days Average Sleep Amount:',
                      style: TextStyle(
                          color: ColorSelect.lightBlue,
                          fontSize: 15
                      )),
                      SfCartesianChart(
                          primaryXAxis: NumericAxis(
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: TextStyle(color: Colors.white),
                          ),

                          series: <ChartSeries>[
                            // Renders line chart
                            LineSeries<ChartData, int>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              color: Colors.black,
                            ),
                          ]
                      ),

                    ]
                ),
              ),
            ),
            actions:
            [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Close",
                style: TextStyle(
                  color: ColorSelect.lightBlue,
                )),
              ),
            ],
          );
        }
    );

  }

  //returns a collection n documents or as many entries as their are if less than n
  Future<QuerySnapshot> getMostRecentSleepRecords(int n) async {
    final x = await databaseReference.get();

    n = min(n, x.size); //account for their being less than n entries

    print(n);

    final querySnapshot = await databaseReference
        .orderBy('goingToSleepTime', descending: true)
        .limit(n)
        .get();

    return querySnapshot;
  }

  String calculateTimeDifference(Timestamp startTime, Timestamp endTime) {
    Duration difference = endTime.toDate().difference(startTime.toDate());
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    return '$hours hours and $minutes minute(s)';
  }

  int calculateTimeDifferenceMinutes(Timestamp timestamp1, Timestamp timestamp2) {
    DateTime dateTime1 = timestamp1.toDate();
    DateTime dateTime2 = timestamp2.toDate();
    int differenceInMinutes = dateTime2.difference(dateTime1).inMinutes;
    return differenceInMinutes;
  }

  String formatTimeOfDay(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  Color sleepQualityColor(String sleepQuality){
    if(sleepQuality =="Terrible")
      sleepQualityC = Colors.red;
    else if (sleepQuality == "Poor")
      sleepQualityC= Colors.orange;
    else if (sleepQuality == "Fair")
      sleepQualityC = Colors.yellow;
    else if (sleepQuality == "Good")
      sleepQualityC = Colors.lightGreen;
    else if (sleepQuality == "Poor")
      sleepQualityC = Colors.green;
    else
      sleepQualityC= Colors.black;
    return sleepQualityC;
  }
}
class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
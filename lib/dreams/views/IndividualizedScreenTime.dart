import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';


class AppScreenTime extends StatefulWidget{
  _AppScreenTime createState() => _AppScreenTime();


}

class _AppScreenTime extends State<AppScreenTime> {
  List<AppUsageInfo> _usageList = [];

  void getUsageStats() async {
    try {
      DateTime endDate =  DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 1));
      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(startDate, endDate);

      //filter out un-needed app time so stats are more accurate
      //infoList = infoList.where((info) => info.packageName != "com.android.settings").toList();
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
  void initState() {
    super.initState();
    getUsageStats();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text('Screen Time By App in H:MM:SS'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemCount: _usageList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: ListTile(
                    leading: Icon(Icons.android),
                    title: Text(_usageList[index].appName),
                    trailing: Text(_usageList[index].usage.toString().split('.').first)
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        child: Icon(Icons.home, size: 25,),
      ),
    );
  }

}

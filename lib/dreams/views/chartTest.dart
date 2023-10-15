import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/dreams_utils.dart';
import 'colors.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.backgroundBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Caffeine Chart', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
        backgroundColor: ColorSelect.appBarBlue,
        iconTheme: IconThemeData(color: ColorSelect.lightBlue),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.lightBlue[50],
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/NoBackgroundKevin.png'),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.width * 1,
                child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 20,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.black,
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.black,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,

                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        //X-Axis Titles
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: bottomTitleWidgets,
                          ),
                        ),

                        //Y-Axis titles
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: leftTitleWidgets,
                            reservedSize: 42,
                          ),
                        ),
                      ),

                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: const Color(0xff37434d)),
                      ),

                      minX: 0,
                      maxX: 12,
                      minY: 0,
                      maxY: 300,
                      lineBarsData: [
                        LineChartBarData(
                          spots:  [
                            FlSpot(0, 120),
                            FlSpot(3.5, 220),
                            FlSpot(5.4, 180),
                            FlSpot(6.5, 100),
                            FlSpot(7, 250),
                            FlSpot(8, 200),
                            FlSpot(11, 220),
                            FlSpot(12, 120),
                          ],
                          isCurved: true,
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                          barWidth: 5,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: gradientColors
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            ],
          ),
        ),
      )
    );

  }
  //these are for the Y axis titles
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 50:
        text = '50mg';
        break;
      case 100:
        text = '100mg';
        break;
      case 150:
        text = '150mg';
        break;
      case 200:
        text = '200mg';
        break;
      case 250:
        text = '250mg';
        break;
      case 300:
        text = '300mg';
        break;
      default:
        return Container();
    }

    return Text(text, style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.backgroundBlue, fontSize: 10, fontWeight: FontWeight.bold)), textAlign: TextAlign.left ,);
  }

  //X axis titles
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '';
        break;
      case 1:
        text = '';
        break;
      case 2:
        text = 'March';
        break;
      case 3:
        text = '';
        break;
      case 4:
        text = '';
        break;
      case 5:
        text = '';
        break;
      case 6:
        text = 'April';
        break;
      case 7:
        text = '';
        break;
      case 8:
        text = '';
        break;
      case 9:
        text = '';
        break;
      case 10:
        text = 'May';
        break;
      case 11:
        text = '';
        break;
      case 12:
        text = '';
        break;
      default:
        return Container();
    }

    return Text(text, textAlign: TextAlign.left, style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.backgroundBlue, fontSize: 10, fontWeight: FontWeight.bold),));
  }


}
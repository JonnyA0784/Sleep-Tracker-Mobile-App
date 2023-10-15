import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/dreams/utils/dreams_utils.dart';
import 'package:units/dreams/views/TipScreen.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:units/main.dart';
import 'package:units/dreams/views/colors.dart';
import 'package:units/dreams/views/SleepVideos.dart';
import '../../main.dart';
import 'package:units/dreams/views/ScreenTime.dart';
import 'package:units/dreams/views/DailyDiary.dart';
import 'package:units/dreams/views/ScreenTime.dart';
import 'package:units/dreams/views/SleepLog.dart';
import 'package:units/dreams/views/SleepNoise.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final UNITSPresenter presenter;

  HomePage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements UNITSView {

  var _sleepHourController = TextEditingController();
  var _sleepMinuteController = TextEditingController();
  var _hourController = TextEditingController();
  var _minuteController = TextEditingController();
  String _hour = "0.0";
  String _minute = "0.0";
  String _sleepMinute = "0.0";
  String _sleepHour = "0.0";
  var _resultString = '';
  var _timeString = '';
  var _message = '';
  var _value = 0;
  var _valueTime = 0;
  final FocusNode _hourFocus = FocusNode();
  final FocusNode _sleepHourFocus = FocusNode();
  final FocusNode _sleepMinuteFocus = FocusNode();
  final FocusNode _minuteFocus = FocusNode();

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.widget.presenter.unitsView = this;
  }

  void handleRadioValueChanged(int? value) {
    this.widget.presenter.onOptionChanged(
        value!, sleepHourString: _sleepHour, sleepMinuteString: _sleepMinute);
  }

  void handleRadioValueChangedTime(int? value) {
    this.widget.presenter.onTimeOptionChanged(value!);
  }

  void _calculator() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      this.widget.presenter.onCalculateClicked(
          _hour, _minute, _sleepMinute, _sleepHour);
    }
  }

  @override
  void updateResultValue(String resultValue) {
    setState(() {
      _resultString = resultValue;
    });
  }

  @override
  void updateTimeString(String timeString) {
    setState(() {
      _timeString = timeString;
    });
  }

  @override
  void updateMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  void updateSleepMinute({required String sleepMinute}) {
    setState(() {
      // ignore: unnecessary_null_comparison
      _sleepMinuteController.text = sleepMinute != null ? sleepMinute : '';
    });
  }

  @override
  void updateSleepHour({required String sleepHour}) {
    setState(() {
      // ignore: unnecessary_null_comparison
      _sleepHourController.text = sleepHour != null ? sleepHour : '';
    });
  }

  @override
  void updateHour({required String hour}) {
    setState(() {
      _hourController.text = hour != null ? hour : '';
    });
  }

  @override
  void updateMinute({required String minute}) {
    setState(() {
      _minuteController.text = minute != null ? minute : '';
    });
  }

  @override
  void updateUnit(int value) {
    setState(() {
      _value = value;
    });
  }

  @override
  void updateTimeUnit(int value) {
    setState(() {
      _valueTime = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    var _unitView = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: ColorSelect.lightBlue,
          value: 0, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Wake up at',
          style: TextStyle(color: ColorSelect.lightBlue),
        ),
        Radio<int>(
          activeColor: ColorSelect.lightBlue,
          value: 1, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Go to bed at',
          style: TextStyle(color: ColorSelect.lightBlue),
        ),
      ],
    );

    var _unitViewTime = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: ColorSelect.lightBlue,
          value: 0,
          groupValue: _valueTime,
          onChanged: handleRadioValueChangedTime,
        ),
        Text(
          'AM',
          style: TextStyle(color: ColorSelect.lightBlue),
        ),
        Radio<int>(
          activeColor: ColorSelect.lightBlue,
          value: 1,
          groupValue: _valueTime,
          onChanged: handleRadioValueChangedTime,
        ),
        Text(
          'PM',
          style: TextStyle(color: ColorSelect.lightBlue),
        ),
      ],
    );

    var _mainPartView = Container(
      decoration: BoxDecoration(
        color: ColorSelect.backgroundBlue,
        borderRadius: BorderRadius.circular(10.0)
      ),
        margin: EdgeInsets.only(top:200.0, bottom: 8.0, right: 8.0, left: 8.0),
        padding: EdgeInsets.only(top:8.0, bottom: 8.0, right: 8.0, left: 8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("I want to:",
                  style: TextStyle(fontWeight: FontWeight.bold, color: ColorSelect.lightBlue),
                  textScaleFactor: 1.5,)
                ,),
              _unitView,
              Row(
                children: <Widget>[
                  Expanded(
                    child: hourFormField(context),
                  ),
                  Expanded(
                    child: minFormField(context),
                  )
                ],
              ),
              _unitViewTime,
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("I want to sleep for:",
                  style: TextStyle(fontWeight: FontWeight.bold, color: ColorSelect.lightBlue),
                  textScaleFactor: 1.5,)
                ,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: sleepHourFormField(context),
                  ),
                  Expanded(
                    child: sleepMinuteFormField(),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: calculateButton()
                ,),
            ],

          ),
        ),
      ),

    );

    var _resultView = Column(
      children: <Widget>[
        Center(
          child: Text(
            '$_message $_resultString $_timeString',
            style: TextStyle(
                color: ColorSelect.lightBlue,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic
            ),
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Sleep Calculator', style: GoogleFonts.dynaPuff(textStyle: TextStyle(color: ColorSelect.lightBlue, fontSize: 25, fontWeight: FontWeight.bold),)),
          centerTitle: true,
          backgroundColor: ColorSelect.appBarBlue,
          iconTheme: IconThemeData(color: ColorSelect.lightBlue),
        ),
        drawer: getMenuBar(context),
        bottomNavigationBar: getBottomNav(context),
        backgroundColor: ColorSelect.backgroundBlue,
        body: /*SingleChildScrollView(
        child:*/ Container(
          //height: MediaQuery.of(context).size.height,
          //width: 412,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sleepAppImage2.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(5.0)),
              _mainPartView,
              Padding(padding: EdgeInsets.all(5.0)),
              _resultView,
              Padding(padding: EdgeInsets.all(5.0)),
            ],
          ),
        ),
        //),
    );
  }

  ElevatedButton calculateButton() {
    return ElevatedButton(
      onPressed: _calculator,
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorSelect.lightBlue,
          textStyle: TextStyle(color: ColorSelect.appBarBlue)
      ),
      child: Text(
        'Calculate',
        style: TextStyle(fontSize: 16.9, color: ColorSelect.appBarBlue, fontWeight: FontWeight.bold),
      ),
    );
  }

  TextFormField sleepMinuteFormField() {
    return TextFormField(
      controller: _sleepMinuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      focusNode: _sleepMinuteFocus,
      onFieldSubmitted: (value) {
        _sleepMinuteFocus.unfocus();
      },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        _sleepMinute = value!;
      },
      decoration: InputDecoration(
          hintText: 'e.g.) 40',
          labelText: 'Minute',
          hintStyle: TextStyle(color: ColorSelect.lightBlue),
          labelStyle: TextStyle(color: ColorSelect.lightBlue),
          icon: Icon(Icons.assessment, color: ColorSelect.lightBlue,),
          fillColor: ColorSelect.lightBlue
      ),
    );
  }

  TextFormField sleepHourFormField(BuildContext context) {
    return TextFormField(
      controller: _sleepHourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _sleepHourFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _sleepHourFocus, _sleepMinuteFocus);
      },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        _sleepHour = value!;
      },
      decoration: InputDecoration(
        hintText: "e.g.) 7",
        labelText: "Hour",
        hintStyle: TextStyle(color: ColorSelect.lightBlue),
        labelStyle: TextStyle(color: ColorSelect.lightBlue),
        icon: Icon(Icons.assessment, color: ColorSelect.lightBlue),
        fillColor: ColorSelect.lightBlue,
      ),
    );
  }

  TextFormField hourFormField(BuildContext context) {
    return TextFormField(
      controller: _hourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _hourFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _hourFocus, _minuteFocus);
      },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        _hour = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 6',
        labelText: 'Hour',
        hintStyle: TextStyle(color: ColorSelect.lightBlue),
        labelStyle: TextStyle(color: ColorSelect.lightBlue),
        icon: Icon(Icons.assessment, color: ColorSelect.lightBlue,),
        fillColor: ColorSelect.lightBlue,
      ),
    );
  }

  TextFormField minFormField(BuildContext context) {
    return TextFormField(
      controller: _minuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _minuteFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _minuteFocus, _sleepHourFocus);
      },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        _minute = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 30',
        labelText: 'Minute',
        hintStyle: TextStyle(color: ColorSelect.lightBlue),
        labelStyle: TextStyle(color: ColorSelect.lightBlue),
        icon: Icon(Icons.assessment, color: ColorSelect.lightBlue,),
        fillColor: ColorSelect.lightBlue,
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
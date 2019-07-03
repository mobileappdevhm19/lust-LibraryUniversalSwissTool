import 'package:flutter/material.dart';
import 'package:lust/pages/pomodoroPage.dart';


class pomodoroDescription extends StatelessWidget {
  int periodTime;
  int oldPeriodTime;

  int shortBreakTime;
  int oldShortBreakTime;

  int longBreakTime;
  int oldLongBreakTime;

  int countPeriods;
  int oldCountPeriods;

  PomodoroState pomPage;

  BuildContext context;


  //Text for the tooltip-snackboxes
  Color errorCol=Colors.red;
  Color infoCol=Colors.black;

  static String haveToClickOK="\n \n You have to click e.g. 'OK' on your keyboard to use your inputs.";
  String breakSnackText="Here you can change the duration of short and long breaks."+haveToClickOK;

  String periodSnackText="Here you can choose the duration of a learning period. \n\n"
                          "You can also choose how many periods till a long break you want to learn"+haveToClickOK;
  

  TextEditingController  periodTimeController;
  TextEditingController  periodCountController;

  TextEditingController  shortBreakController;
  TextEditingController  longBreakController;

  pomodoroDescription(){
    periodTimeController = new TextEditingController();
    periodCountController = new TextEditingController();

    shortBreakController = new TextEditingController();
    longBreakController = new TextEditingController();
  }

  void setValues(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods, PomodoroState pomPage){
    this.periodTime=periodTime;
    this.shortBreakTime=shortBreakTime;
    this.longBreakTime=longBreakTime;
    this.countPeriods=countPeriods;
    setValuesToTextFields();
    this.pomPage=pomPage;
    updateValues(true); //to set old values
  }
  @override
  Widget build(BuildContext context) {
    this.context=context;
    const double margin=10;
    double dividerHeight = 1.0;
    double dividerIndent = 0.0;
    Color dividerColor = Colors.black;

    return new Container(
      margin: const EdgeInsets.only(left: margin, right: margin, top: margin, bottom: margin),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            headlineWithWidget("Period",  Icons.help, periodSnackText, context),

            new Row(
              children: <Widget>[
               Expanded(child: new Column(
                children: <Widget>[
                  TextField(
                    decoration: new InputDecoration(labelText: "time [min]", ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    controller: periodTimeController,
                    onSubmitted: (text) {
                      periodTime=int.parse(periodTimeController.text);
                      updateValues();
                    },
                  ),
                ]),
               ),
               VerticalDivider(),
               Expanded(child: new Column(
                    children: <Widget>[
                      TextField(
                        decoration: new InputDecoration(labelText: "count", ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        controller: periodCountController,
                        onSubmitted: (text) {
                          countPeriods=int.parse(periodCountController.text);
                          updateValues();
                        },
                      ),
                    ]),
                ),

              ],
            ),

            new HorizontalDivider(),

            headlineWithWidget("Break",  Icons.help, breakSnackText, context),

            new Row(
              children: <Widget>[
                Expanded(child: new Column(
                    children: <Widget>[
                      TextField(
                        decoration: new InputDecoration(labelText: "short [min]", ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        controller: shortBreakController,
                        onSubmitted: (text) {
                          shortBreakTime=int.parse(shortBreakController.text);
                          updateValues();
                        },
                      ),
                    ]),
                ),
                VerticalDivider(),
                Expanded(child: new Column(
                    children: <Widget>[
                      TextField(
                        decoration: new InputDecoration(labelText: "long [min]", ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        controller: longBreakController,
                        onSubmitted: (text) {
                          longBreakTime=int.parse(longBreakController.text);
                          updateValues();
                        },
                      ),
                    ]),
                ),
              ],
            ),
            new HorizontalDivider(),
          ]),
    );
  }

  //setter for the text fields
  void setValuesToTextFields(){
    print("in setValuesToTextFields $periodTime");
    periodTimeController.text=periodTime.toString();
    periodCountController.text=countPeriods.toString();

    shortBreakController.text=shortBreakTime.toString();
    longBreakController.text=longBreakTime.toString();
  }


  Row headlineWithWidget(String text, IconData icon, String snackText, BuildContext context){

    return new Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            child: Text(
              "$text",
              textScaleFactor: 0.8,
              style: TextStyle(fontSize: 30.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(
          alignment: Alignment.topLeft,
          child: IconButton(
            iconSize: 30.0,
            icon: Icon(icon),
            //color: theme.iconTheme.color,
            tooltip: 'Tooltip for $text',
            onPressed: () {
              printSnackBoc(snackText, infoCol);
            },
          ),
        ),
        ),
      ],
    );
  }


  void updateValues([bool init=false]){
    bool ret=testInputs();
    if(ret==false && init==false){ //set all to old values
      setOldValues();
    }
    else{ //set new values
      if(pomPage !=null){
        pomPage.updateVales(periodTime, shortBreakTime, longBreakTime, countPeriods);
      }
    }

    //set values to old value
    oldPeriodTime=periodTime;
    oldShortBreakTime=shortBreakTime;
    oldLongBreakTime=longBreakTime;
    oldCountPeriods=countPeriods;
  }

  void setOldValues(){
    periodTime=oldPeriodTime;
    shortBreakTime= oldShortBreakTime;
    longBreakTime=oldLongBreakTime;
    countPeriods=oldCountPeriods;

    setValuesToTextFields();//set the values to the textFields
  }

  //snackbox when silly inputs
  //true, when only warning/ info
  //false, when error (use old value)
  bool testInputs(){
    String snackText;


    //all error things

    //cases, when variable <0
      String varName="";
      String oldVal="";

    if(periodTime<=0){
      varName="period time";
      oldVal=pomPage.periodTime.toString();
    }

    if(countPeriods<=0){
      varName="count of periods";
      oldVal=pomPage.countPeriods.toString();
    }

    if(shortBreakTime<=0){
      varName="short break time";
      oldVal=pomPage.shortBreakTime.toString();
    }

    if(longBreakTime<=0){
      varName="long break time";
      oldVal=pomPage.longBreakTime.toString();
    }


      if(varName !=""){
        snackText="Your Input for '"+varName+"' is <=0. \n"
            "Pomodoro Timer will still use the old value: "+oldVal;
        printSnackBoc(snackText, errorCol);
        return false;
      }

      //info messages (multiple messages after another possible)
    if(shortBreakTime>=periodTime || longBreakTime>=periodTime){
      snackText="Breaktime is longer than your learning time! \n"
          "You are so lazy";
      printSnackBoc(snackText, infoCol);
    }

    if(shortBreakTime> longBreakTime){
      snackText="short break time longer than long break Time \n"
          "That is useless";
      printSnackBoc(snackText, infoCol);
    }

    return true;

  }

  void printSnackBoc(String text, Color color){
    const dur = const Duration(seconds: 5);
  if(this.context==null)return;
    Scaffold.of(this.context).showSnackBar(SnackBar(
        content: Text("$text"),
      backgroundColor: color,
      duration: dur,
    ));
  }
}


class emptyColumn extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new Column(
      children: <Widget>[
      Expanded(child: new Row(
      children: <Widget>[
        Text("hi"),
      ])),
    ]);
  }
}


class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.black,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}


class HorizontalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        height: 10.0,
        child: new Center(
        child: new Container(
        margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
    height: 5.0,
    color: Colors.black,
    ),
    ));
  }
}


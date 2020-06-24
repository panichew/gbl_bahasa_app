import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gblbahasaapp/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

var questionNumber = 0;
var quiz = new Practice1Quiz();
AudioCache plyr = AudioCache();

class Practice1Quiz {
  var sound = [
    "card1.wav",
    "card22.wav",
    "card18.wav",
    "card35.wav",
    "voice408.wav",
  ];

  var choices = [
    ["Ba", "Fa", "Pi", "Re"],
    ["Di", "Fe", "Je", "Gi"],
    ["Ju", "Fu", "Bo", "To"],
    ["Jo", "Po", "Wu", "Gu"],
    [
      "BeRi",
      "LaRi",
      "LaMe",
      "KaJi",
    ]
  ];

  var correctAnswers = ["Ba", "Gi", "Fu", "Jo", "LaRi"];
}

double percent = questionNumber / quiz.correctAnswers.length;

// Intro Page
class Practice1Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColour,
      appBar: AppBar(
        title: new RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: 'PRACTICE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              TextSpan(text: "\n"),
              TextSpan(
                  text: 'Pronunciation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0))
            ])),
        centerTitle: true,
        flexibleSpace: kColorAppBarPractice,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(4),
              child: Text(
                "Multiple Choice Quiz",
                style: TextStyle(
                  fontSize: 36.0,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 5,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Text(
                "This game is a multiple choices question with four answer choices. "
                "You need to answer correctly to proceed to the next question.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              height: 45,
              width: 180,
              child: RaisedButton(
                color: Colors.lightBlueAccent,
                elevation: 7,
                highlightColor: Colors.grey,
                child: Text(
                  "Start Game",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Practice1()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Quiz Page
class Practice1 extends StatefulWidget {
  @override
  _Practice1State createState() => _Practice1State();
}

class _Practice1State extends State<Practice1> {
  // Audio Player
  void playSound(String voices) {
    final player = AudioCache();
    player.play('sound/${quiz.sound[questionNumber]}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: kMainBackgroundColour,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                resetQuiz();
              },
            ),
            title: new RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PRACTICE',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                      text: 'Pronunciation',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0))
                ])),
            centerTitle: true,
            flexibleSpace: kColorAppBarPractice,
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: LinearPercentIndicator(
                  width: 395.0,
                  lineHeight: 8.0,
                  percent: percent,
                  backgroundColor: Color(0xffFFCBC2),
                  progressColor: kColorMainPractice,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 4, 16, 0),
                alignment: Alignment.centerRight,
                child: Text(
                  "${(percent * 100).toStringAsFixed(0)}" + "% Completed",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kFontColorSecondary,
                      fontSize: 16),
                ),
              ),
              Container(
                child: new Text.rich(TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Guess the sound pronunciation.\n',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Click the sound icon to hear the pronunciation.\n',
                      //'Tap the card to hear the word pronunciation.',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          color: kFontColorSecondary),
                    ),
                  ],
                )),
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                alignment: Alignment.centerLeft,
                height: 100,
              ),
              Container(
                height: 260,
                width: 230,
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Question ${questionNumber + 1} of ${quiz.correctAnswers.length}",
                        style: new TextStyle(
                            fontSize: 22.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: kFontColorSecondary),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Ink(
//                      decoration: ShapeDecoration(shadows: [
//                        BoxShadow(
//                          blurRadius: 5,
//                        )
//                      ], color: Colors.white, shape: CircleBorder()),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.volumeUp,
                            color: Colors.black,
                          ),
                          iconSize: 120,
                          highlightColor: Colors.white30,
                          onPressed: () {
                            playSound(quiz.sound[questionNumber]);
                            //"images/${quiz.images[questionNumber]}.jpg",
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                          Icon(
//                            FontAwesomeIcons.play,
//                            size: 20,
//                          ),
//                          SizedBox(
//                            width: 20,
//                          ),
                          Text(
                            'Click to play sound',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                padding: EdgeInsets.only(left: 36),
                alignment: Alignment.centerLeft,
                height: 50,
                child: Text(
                  'Choose the correct answer:',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: kFontColorSecondary),
                ),
              ),

              // Multiple Choice
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //button 1
                  new MaterialButton(
                    elevation: 7,
                    minWidth: 150.0,
                    height: 70,
                    color: Colors.white,
                    splashColor: Colors.lightBlueAccent,
                    onPressed: () {
                      if (quiz.choices[questionNumber][0] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint("Correct");
                        print(percent);
                        answerTrue();
                      } else {
                        debugPrint("Wrong");
                        answerFalse();
                      }
                    },
                    child: new Text(
                      quiz.choices[questionNumber][0],
                      style: new TextStyle(
                          fontSize: 50.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  //button 2
                  new MaterialButton(
                    elevation: 7,
                    minWidth: 150.0,
                    height: 70,
                    color: Colors.white,
                    splashColor: Colors.lightBlueAccent,
                    onPressed: () {
                      if (quiz.choices[questionNumber][1] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint("Correct");
                        answerTrue();
                      } else {
                        debugPrint("Wrong");
                        answerFalse();
                      }
                    },
                    child: new Text(
                      quiz.choices[questionNumber][1],
                      style: new TextStyle(
                          fontSize: 50.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 24,
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //button 3
                  new MaterialButton(
                    elevation: 7,
                    minWidth: 150.0,
                    height: 70,
                    color: Colors.white,
                    splashColor: Colors.lightBlueAccent,
                    onPressed: () {
                      if (quiz.choices[questionNumber][2] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint("Correct");
                        answerTrue();
                      } else {
                        debugPrint("Wrong");
                        answerFalse();
                      }
                    },
                    child: new Text(
                      quiz.choices[questionNumber][2],
                      style: new TextStyle(
                          fontSize: 50.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  //button 4
                  new MaterialButton(
                    elevation: 7,
                    minWidth: 150.0,
                    height: 70,
                    color: Colors.white,
                    splashColor: Colors.lightBlueAccent,
                    onPressed: () {
                      if (quiz.choices[questionNumber][3] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint("Correct");
                        answerTrue();
                      } else {
                        debugPrint("Wrong");
                        answerFalse();
                      }
                    },
                    child: new Text(
                      quiz.choices[questionNumber][3],
                      style: new TextStyle(
                          fontSize: 50.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }

  // True method
  void answerTrue() {
    plyr.play("correct.wav");
    if (percent == 1) {
      percent += 0;
    } else {
      percent += 0.2;
    }
    setState(() {
      showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 120,
              color: kColorCorrect,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "You are correct",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          color: kColorAppleGreen2),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: kColorAppleGreen2)),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            updateQuestion();
                          }),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }

  // False method
  void answerFalse() {
    plyr.play("wrong.wav");
    setState(() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 120,
              color: kColorWrong,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Wrong Answer",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          color: kColorBitterSweet2),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        child: const Text(
                          'Try Again',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }

  // Reset method
  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      percent = 0;
      questionNumber = 0;
    });
  }

  // Update method
  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.correctAnswers.length - 1) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => Practice1End()));
      } else {
        questionNumber++;
      }
    });
  }
}

// Game Over
class Practice1End extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kMainBackgroundColour,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              percent = 0;
              Navigator.pop(context);
              Navigator.pop(context);
              questionNumber = 0;
            },
          ),
          title: new RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: 'PRACTICE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                    text: 'Pronunciation',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0))
              ])),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Quiz End",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                width: 180,
                child: RaisedButton(
                  color: kColorMainPractice,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.redAccent)),
                  child: Text(
                    "Play Again",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    percent = 0;
                    questionNumber = 0;
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 180,
                child: RaisedButton(
                  color: kColorMainPractice,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.redAccent)),
                  child: Text(
                    "Exit",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    percent = 0;
                    questionNumber = 0;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

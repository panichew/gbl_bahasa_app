import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gblbahasaapp/constant.dart';

AudioCache plyr = AudioCache();

// Intro Page
class Practice6Intro extends StatelessWidget {
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
                  text: 'Colors and Shapes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0))
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
                "Drag and Drop Game",
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
                "Drag and drop the card onto the box with their respective meaning. "
                "You need to answer correctly to finish the game.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400),
              ),
            ),
            RaisedButton(
              color: Colors.lightBlueAccent,
              elevation: 5,
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
                  MaterialPageRoute(builder: (context) => Practice6()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Practice6 extends StatefulWidget {
  @override
  _Practice6State createState() => _Practice6State();
}

class _Practice6State extends State<Practice6> {
  /// Map to keep track of score
  final Map<String, bool> score = {};

  /// Choices for game
  final Map choices = {
    'Hijau': Colors.green,
    'Kuning': Colors.yellow,
    'Merah': Colors.red,
    'Ungu': Colors.purple,
    'Biru': Colors.blue,
    'Jingga': Colors.orange,
  };

  // Random seed to shuffle order of items.
  int seed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
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
                  text: 'Pronouns',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0))
            ])),
        centerTitle: true,
        flexibleSpace: kColorAppBarPractice,
      ),
      body: Column(
        children: <Widget>[
          //Instruction
          Container(
            child: new Text.rich(TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Match the card with their meaning.\n',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Drag the card and place it in the right color box.\n',
                  //'Tap the card to hear the word pronunciation.',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: kFontColorSecondary),
                ),
              ],
            )),
            padding: EdgeInsets.all(kMainPadding),
            alignment: Alignment.centerLeft,
            height: 100,
          ),
          // Body
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: <Widget>[
                // Language
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        " Bahasa Malaysia",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: kFontColorSecondary),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Text(
                        "Color Box        ",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: kFontColorSecondary),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: choices.keys.map((card) {
                          return Draggable<String>(
                            data: card,
                            child: DragCard(
                                card: score[card] == true ? '✅' : card),
                            feedback: DragCard(card: card),
                            childWhenDragging: Container(
                              height: 80,
                              width: 150,
                            ),
                          );
                        }).toList()),
                    Container(
                      color: Colors.black,
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: choices.keys
                          .map((card) => _buildDragTarget(card))
                          .toList()
                            ..shuffle(Random(seed)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Drag target method
  Widget _buildDragTarget(card) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[card] == true) {
          return Container(
            height: 63,
            width: 150,
            margin: EdgeInsets.all(8),
            color: choices[card],
            child: Text(
              'Correct!',
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.center,
          );
        } else {
          return Container(
            height: 63,
            width: 150,
            margin: EdgeInsets.all(8),
            color: Colors.white30,
            child: Card(
                color: choices[card],
                child: Text(
                  "",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
          );
        }
      },
      onWillAccept: (data) {
        return data == card;
      },
      onAccept: (data) {
        setState(() {
          score[card] = true;
          plyr.play('correct.wav');
        });
        if (score.length == 6) {
          answerTrue();
        }
      },
      onLeave: (data) {
        setState(() {});
      },
    );
  }

  // Answer True method
  void answerTrue() {
//    plyr.play("correct.wav");
    setState(() {
      showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 180,
              color: kColorCorrect,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Game Finished!",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          color: kColorAppleGreen2),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //button play again
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: kColorAppleGreen2)),
                        child: const Text(
                          'Play again.',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    // button exit
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: kColorAppleGreen2)),
                        child: const Text(
                          'Main Menu.',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            );
          });
    });
  }
}

//Card class
class DragCard extends StatelessWidget {
  DragCard({Key key, this.card}) : super(key: key);

  final String card;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 150,
      child: Card(
        margin: EdgeInsets.all(12),
        elevation: 8,
        child: Center(
          child: Text(
            card,
            style: TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
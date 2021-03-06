import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gblbahasaapp/constant.dart';

class Learn6 extends StatefulWidget {
  @override
  _Learn6State createState() => _Learn6State();
}

class _Learn6State extends State<Learn6> {
  int _index = 0;

  void playSound(String voices) {
    final player = AudioCache();
    player.play('voices/$voices');
  }

  List<String> images = [
    'assets/images/red.png',
    'assets/images/blue.png',
    'assets/images/green.png',
    'assets/images/yellow.png',
    'assets/images/purple.png',
    'assets/images/orange.png',
    'assets/images/black.png',
    'assets/images/white.png',
    'assets/images/gray.png',
    'assets/images/circle.png',
    'assets/images/triangle.png',
    'assets/images/square.png',
  ];

  List<String> melayu = [
    'Merah',
    'Biru',
    'Hijau',
    'Kuning',
    'Ungu',
    'Jingga',
    'Hitam',
    'Putih',
    'Kelabu',
    'Bulat',
    'Segi Tiga',
    'Segi Empat',
  ];

  List<String> english = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Purple',
    'Orange',
    'Black',
    'White',
    'Gray',
    'Circle',
    'Triangle',
    'Square',
  ];

  List<String> voices = [
    'voice601.wav',
    'voice602.wav',
    'voice603.wav',
    'voice604.wav',
    'voice605.wav',
    'voice606.wav',
    'voice607.wav',
    'voice608.wav',
    'voice609.wav',
    'voice610.wav',
    'voice611.wav',
    'voice612.wav',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainBackgroundColour,
        appBar: AppBar(
          flexibleSpace: kColorAppBarLearn,
          centerTitle: true,
          title: new RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: 'LEARN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                    text: 'Colours and Shapes',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0))
              ])),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: new Text.rich(TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Learn words:\n',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Swipe right or left to learn new words.\n',
                    //'Tap the card to hear the word pronunciation.',
                    style: TextStyle(
                        fontSize: 18.0,
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

            // Body //
            Container(
              height: 550,
              padding: EdgeInsets.fromLTRB(0, kMainPadding, 0, kMainPadding),
              child: Center(
                child: SizedBox(
                  height: 550, // card height
                  child: PageView.builder(
                    itemCount: 12,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            padding: EdgeInsets.all(kMainPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Colours and Shapes",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: 20,
                                ),
                                Image.asset(
                                  images[i],
                                  height: 250,
                                ),
                                Column(
                                  children: <Widget>[
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        melayu[i], //"Card ${i + 1}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 42,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      english[i],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 32.0,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.bold,
                                          color: kFontColorSecondary),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.volume_up),
                                      tooltip: 'Increase volume by 10',
                                      iconSize: 50,
                                      onPressed: () {
                                        playSound(voices[i]);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

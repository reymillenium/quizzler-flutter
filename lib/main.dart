import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> childrenIcons = [];

  // Widget createRightIcon() {
  //   return (Icon(
  //     Icons.done,
  //     color: Colors.green,
  //   ));
  // }
  //
  // Widget createWrongIcon() {
  //   return (Icon(
  //     Icons.close,
  //     color: Colors.red,
  //   ));
  // }

  Widget createIcon({IconData icon, Color color}) {
    return (Icon(
      icon,
      color: color,
    ));
  }

  void addRightIcon() {
    setState(() {
      // childrenIcons.add(createRightIcon());
      childrenIcons.add(createIcon(icon: Icons.done, color: Colors.green));
    });
  }

  void addWrongIcon() {
    setState(() {
      // childrenIcons.add(createRightIcon());
      childrenIcons.add(createIcon(icon: Icons.close, color: Colors.red));
    });
  }

  void addIcon(bool isCorrect) {
    setState(() {
      // childrenIcons.add(createRightIcon());
      // childrenIcons.add(createIcon(icon: Icons.close, color: Colors.red));
      Widget icon = (isCorrect ? createIcon(icon: Icons.done, color: Colors.green) : createIcon(icon: Icons.close, color: Colors.red));
      childrenIcons.add(icon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'This is where the question text will go.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                addIcon(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                addIcon(false);
              },
            ),
          ),
        ),

        //  Score keeper
        Row(
          children: childrenIcons,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

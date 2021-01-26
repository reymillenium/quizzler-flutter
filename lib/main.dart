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
  List<Icon> childrenIcons = [];
  int index = 0;
  List<Map> questionnaire = [
    {'question': 'You can lead a cow down stairs but not up stairs.', 'answer': false},
    {'question': 'Approximately one quarter of human bones are in the feet.', 'answer': true},
    {'question': 'A slug\'s blood is green.', 'answer': true},
  ];

  Widget createIcon({IconData icon = Icons.done, Color color = Colors.green}) {
    return (Icon(
      icon,
      color: color,
    ));
  }

  void addIcon(bool isCorrect) {
    setState(() {
      Icon newIcon = (isCorrect ? createIcon() : createIcon(icon: Icons.close, color: Colors.red));
      childrenIcons.add(newIcon);
      // print(newIcon);
      // print(newIcon.color);
      // print(newIcon.color.value);
      // if (newIcon.icon.hashCode == Icons.done.hashCode) {
      //   print('Its a right icon');
      // } else if (newIcon.icon.hashCode == Icons.close.hashCode) {
      //   print('Its a wrong icon');
      // }
      // print(newIcon.icon.hashCode);
    });
  }

  void increaseIndex() {
    setState(() {
      index++;
    });
  }

  void evaluateAnswer(bool answer) {
    addIcon(answer == questionnaire[index]['answer']);
    if (index < questionnaire.length - 1) {
      increaseIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (childrenIcons.isEmpty) {
    //   childrenIcons.add(createIcon(icon: Icons.phone, color: Colors.grey.shade900));
    //   // childrenIcons.add(createIcon(icon: Icons.phone, color: Colors.green));
    // } else if (childrenIcons.length > 1 && childrenIcons.first.icon.hashCode == Icons.phone.hashCode) {
    //   childrenIcons.removeAt(0);
    // }

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
                // 'This is where the question text will go.',
                questionnaire[index]['question'],
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
                // addIcon(true);
                evaluateAnswer(true);
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
                // addIcon(false);
                evaluateAnswer(false);
              },
            ),
          ),
        ),

        //  Score keeper
        Container(
          height: 30.0,
          child: Row(
            children: childrenIcons,
          ),
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

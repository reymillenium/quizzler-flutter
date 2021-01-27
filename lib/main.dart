import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:audioplayers/audioplayers.dart';

QuizBrain quizBrain = QuizBrain();

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
  AudioCache player = AudioCache();
  List<Icon> childrenIcons = [];
  int index = 0;

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
    });
  }

  void playSound(bool isCorrect) {
    String audioFileName = isCorrect ? 'right_answer.wav' : 'wrong_answer.wav';
    player.play(audioFileName);
  }

  void increaseIndex() {
    setState(() {
      index++;
    });
  }

  void resetIndex() {
    setState(() {
      index = 0;
    });
  }

  void answerQuestion(bool answer) {
    if (index > quizBrain.initialMaxIndex()) {
      setState(() {
        quizBrain.removeLast();
        childrenIcons.removeRange(0, childrenIcons.length);
      });
      resetIndex();
    } else {
      addIcon(answer == quizBrain.getQuestion(index).answer);
      playSound(answer == quizBrain.getQuestion(index).answer);
      if (index == quizBrain.initialMaxIndex()) {
        setState(() {
          quizBrain.addQuestion(evaluateAnswers(), true);
        });
      }
      increaseIndex();
    }
  }

  String evaluateAnswers() {
    int rightAnswersAmount = childrenIcons.where((e) => e.icon.hashCode == Icons.done.hashCode).length;
    int wrongAnswersAmount = childrenIcons.where((e) => e.icon.hashCode == Icons.close.hashCode).length;
    String firstEvaluation = 'You had ${rightAnswersAmount == 0 ? 'no' : rightAnswersAmount} right answer${rightAnswersAmount == 1 ? '' : 's'} and ${wrongAnswersAmount == 0 ? 'no' : wrongAnswersAmount} wrong answer${wrongAnswersAmount == 1 ? '' : 's'}. ';
    String finalOpinion = rightAnswersAmount == childrenIcons.length ? 'You are very wise!' : (wrongAnswersAmount == childrenIcons.length ? 'You definitely need to read a little more!' : (rightAnswersAmount > wrongAnswersAmount ? 'Not so bad. Good job!' : 'Keep reading!'));

    return firstEvaluation + finalOpinion;
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
                // 'This is where the question text will go.',
                quizBrain.getQuestion(index).question,
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
                answerQuestion(true);
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
                answerQuestion(false);
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

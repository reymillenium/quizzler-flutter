import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Text('Quizzler'),
        ),
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
  @override
  Widget build(BuildContext context) {
    final slider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
        infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        customWidths: CustomSliderWidths(progressBarWidth: 10),
        customColors: CustomSliderColors(
          shadowColor: Colors.white,
          trackColor: Colors.black38,
          progressBarColors: [Colors.green, Colors.yellowAccent, Colors.redAccent],
        ),
      ),
      min: quizBrain.percentagePerAmount(1),
      max: quizBrain.percentagePerAmount(13),
      initialValue: quizBrain.currentPercentage(),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: slider,
            ),
          ),
        ),

        //
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                // 'This is where the question text will go.',
                quizBrain.getCurrentQuestionText(),
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
                setState(() {
                  quizBrain.answerQuestion(true, context);
                });
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
                setState(() {
                  quizBrain.answerQuestion(false, context);
                });
              },
            ),
          ),
        ),

        //  Score keeper
        Container(
          height: 30.0,
          child: Row(
            children: quizBrain.childrenIcons(),
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

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'question.dart';

class QuizBrain {
  int _initialMaxIndex;
  int _index = 0;
  List<Icon> _childrenIcons = [];
  AudioCache _player = AudioCache();

  List<Question> _questionnaire = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question('No piece of square dry paper can be folded in half more than 7 times.', false),
    Question('In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.', true),
    Question('The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.', false),
    Question('The total surface area of two human lungs is approximately 70 square metres.', true),
    Question('Google was originally called \"Backrub\".', true),
    Question('Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.', true),
    Question('In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.', true),
  ];

  // Constructor:
  QuizBrain() {
    this._initialMaxIndex = _questionnaire.length - 1;
  }

  // Getters:
  String getCurrentQuestionText() {
    return _questionnaire[_index].question;
  }

  List<Icon> childrenIcons() {
    return _childrenIcons;
  }

  // Public Methods
  void answerQuestion(bool answer) {
    if (_index > _initialMaxIndex) {
      _questionnaire.removeLast();
      _childrenIcons.removeRange(0, _childrenIcons.length);
      _index = 0;
    } else {
      _addIcon(answer == _getCurrentQuestion().answer);
      _playSound(answer == _getCurrentQuestion().answer);
      if (_index == _initialMaxIndex) {
        _addQuestion(_evaluateAnswers(), true);
      }
      _index++;
    }
  }

  // Private Methods
  Widget _createIcon({IconData icon = Icons.done, Color color = Colors.green}) {
    return (Icon(
      icon,
      color: color,
    ));
  }

  void _playSound(bool isCorrect) {
    String audioFileName = isCorrect ? 'right_answer.wav' : 'wrong_answer.wav';
    _player.play(audioFileName);
  }

  Question _getCurrentQuestion() {
    return _questionnaire[_index];
  }

  void _addQuestion(String questionText, bool answer) {
    _questionnaire.add(Question(questionText, answer));
  }

  void _addIcon(bool isCorrect) {
    Icon newIcon = (isCorrect ? _createIcon() : _createIcon(icon: Icons.close, color: Colors.red));
    _childrenIcons.add(newIcon);
  }

  String _evaluateAnswers() {
    int totalAnswersAmount = _childrenIcons.length;
    int rightAnswersAmount = _childrenIcons.where((e) => e.icon.hashCode == Icons.done.hashCode).length;
    int wrongAnswersAmount = _childrenIcons.where((e) => e.icon.hashCode == Icons.close.hashCode).length;
    String firstEvaluation = 'You had ${rightAnswersAmount == 0 ? 'no' : rightAnswersAmount} right answer${rightAnswersAmount == 1 ? '' : 's'} and ${wrongAnswersAmount == 0 ? 'no' : wrongAnswersAmount} wrong answer${wrongAnswersAmount == 1 ? '' : 's'}. ';
    String finalOpinion = rightAnswersAmount == totalAnswersAmount ? 'You are very wise!' : (wrongAnswersAmount == totalAnswersAmount ? 'You definitely need to read a little more!' : (rightAnswersAmount > wrongAnswersAmount ? 'Not so bad. Good job!' : 'Keep reading!'));
    return firstEvaluation + finalOpinion;
  }
}

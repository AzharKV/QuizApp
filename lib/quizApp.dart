import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'QuizBank.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> scoreKeeper = [];
  QuizBank quizBank = QuizBank();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBank.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Row(children: scoreKeeper),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              onPressed: () => checkAnswer(true),
              color: Colors.green,
              textColor: Colors.white,
              child: Text(
                "True",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: MaterialButton(
              onPressed: () => checkAnswer(false),
              color: Colors.red,
              textColor: Colors.white,
              child: Text(
                "False",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBank.getCorrectAns();
    setState(() {
      if (quizBank.isFinished() == true) {
        Alert(
                context: context,
                title: "Finished",
                desc: "You\'ve reached the end of quiz")
            .show();
        quizBank.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBank.nextQuestion();
      }
    });
  }
}

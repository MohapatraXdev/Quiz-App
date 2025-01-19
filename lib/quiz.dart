import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/questions.dart';
import 'package:flutter_application_1/question_screen.dart';
import 'package:flutter_application_1/result_screen.dart';
import 'package:flutter_application_1/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // Widget? activeScreen;

// @override
//   void initState() {
//     activeScreen = StartScreen(switchScreen);
//     super.initState();
//   }    **1st method

  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void restartQuiz(){
    setState(() {
      activeScreen = 'start-screen';
      selectedAnswer = [];
    });
  }

  List<String> selectedAnswer = [];

  void chooseAnswer(String answers) {
    selectedAnswer.add(answers);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(context) {
    //final switchWidget = activeScreen == 'start-screen' ? StartScreen(switchScreen) : const QuestionScreen(); **3rd method
    Widget switchWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      switchWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    } else if (activeScreen == 'results-screen') {
      switchWidget = ResultScreen(chosenAnswers: selectedAnswer, restartQuiz: restartQuiz,);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 23, 202)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          //  child : activeScreen, **1st method
          //  child: activeScreen == 'start-screen' ? StartScreen(switchScreen) : const QuestionScreen(),  **2nd method
          //  child : switchWidget, **3rd method
          child: switchWidget,
        ),
      ),
    );
  }
}

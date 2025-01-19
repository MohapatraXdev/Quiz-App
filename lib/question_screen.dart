import 'package:flutter/material.dart';
import 'package:Quiz_App/answer_button.dart';
import 'package:Quiz_App/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    //  currentQuestion = currentQuestion + 1;  **  increment the currentQuestion value by 1
    //  currentQuestion+=1;                     **  shortcut method 1 to increment the value by 1
    setState(() {
      currentQuestionIndex++; //  **  shortcut method 2 to increment the value by 1
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                currentQuestion.text,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 200, 139, 235),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              ...currentQuestion.getShuffledAnswers().map((answer) {
                return AnswerButton(
                    answerText: answer,
                    onTap: () {
                      answerQuestion(answer);
                    });
              }), // replace "answers" List with new shuffledAnswers List to have the shuffled answers

              //  ...currentQuestion.answers.map((item) {
              //    return AnswerButton(answerText: item, onTap: () {});
              //  }),                                                                   ** method 2 (answers not shuffled yet)

              //  AnswerButton(answerText: currentQuestion.answers[0], onTap: (){}),    ** method 1 (answers not shuffled yet)
              //  AnswerButton(answerText: currentQuestion.answers[1], onTap: (){}),    ** method 1 (answers not shuffled yet)
              //  AnswerButton(answerText: currentQuestion.answers[2], onTap: (){}),    ** method 1 (answers not shuffled yet)
              //  AnswerButton(answerText: currentQuestion.answers[3], onTap: (){}),    ** method 1 (answers not shuffled yet)
            ],
          ),
        ));
  }
}

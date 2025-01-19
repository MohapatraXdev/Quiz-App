import 'package:flutter/material.dart';
import 'package:Quiz_App/data/questions.dart';
import 'package:Quiz_App/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenAnswers, required this.restartQuiz});

  final List<String> chosenAnswers;

  final void Function() restartQuiz;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'You answered  out $numCorrectQuestions of $numTotalQuestions questions correctly!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData),
            const SizedBox(height: 30),
            TextButton(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                iconColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20), // Optional padding
              ),
              child: Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the button size fits its content
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.white, // Icon color set to white
                  ),
                  SizedBox(width: 10), // Space between the icon and the text
                  Text(
                    'Restart Quiz!',
                    style: TextStyle(
                      color: Colors.white, // Text color set to white
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

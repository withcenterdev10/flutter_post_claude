// import 'package:flutter/material.dart';
// import 'package:flutter_friday_test/models/question_model.dart';
// import 'package:provider/provider.dart';

// class DemoState extends ChangeNotifier {
//   List<QuestionModel>? state;
//   QuestionModel? selectedQuestion;

//   static DemoState Function(BuildContext context) of = (context) =>
//       context.read<DemoState>();

//   void clearSelectedQuestion() {
//     selectedQuestion = null;
//   }

//   void createQuestion(QuestionModel question) {
//     state = [...?state, question];
//     notifyListeners();
//   }

//   void setQuestions(List<QuestionModel> questions) {
//     state = questions;
//     notifyListeners();
//   }

//   void setSelectedQuestion(QuestionModel question) {
//     selectedQuestion = question;
//     notifyListeners();
//   }

//   QuestionModel fetchQuestion(String questionId) {
//     // final question = repository.fetchQuestion(questionId: questionId);
//     // selectedQuestion = question;
//     // notifyListeners();
//     // return question;
//     return QuestionModel(
//       question: "question",
//       answer1: "answer1",
//       answer2: "answer2",
//       answer3: "answer3",
//       answer4: "answer4",
//       correctAnswer: "correctAnswer",
//     );
//   }

//   void updatedQuestion(QuestionModel question) {
//     final updatedQuestionList = state!.map((q) {
//       if (q.id == question.id) {
//         return question;
//       } else {
//         return question;
//       }
//     }).toList();

//     state = updatedQuestionList;
//     notifyListeners();
//   }
// }

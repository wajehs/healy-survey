import 'package:healy_survey/components/models/serivce/survey_question_answer.dart';

class SurveyQuestion {
  SurveyQuestion({
    required this.id,
    required this.text,
    required this.type,
    required this.isRequired,
    required this.answers,
  });

// to create SurveyQuestion objec from decoded json data
  static SurveyQuestion fromJson(Map<String, dynamic> jsonData) {
    return SurveyQuestion(
        id: jsonData['id'],
        text: jsonData['text'],
        type: jsonData['type'],
        isRequired: jsonData['required'],
        answers: jsonData
                .containsKey('answers') // to get list of SurveyQuestionAnswer object
            ? (jsonData['answers'] as List<dynamic>)
                .map((e) => SurveyQuestionAnswer.fromJson(e))
                .toList()
            : []);
  }

  String id;
  String text, type;
  bool isRequired;
  List<SurveyQuestionAnswer> answers;
  dynamic questionAnswer;
}

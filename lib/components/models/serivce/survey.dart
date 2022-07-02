import 'package:healy_survey/components/models/serivce/survey_question.dart';

class Survey {
  Survey({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.termsAndConditionsUrl,
    required this.finishText,
    this.startedAt,
    this.endedAt,
    required this.surveyQuestions,
  });

  // to get Survey object from decoded json
  static Survey fromJson(Map<String, dynamic> jsonData) {
    return Survey(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description'],
        imageUrl: jsonData['imageUrl'],
        termsAndConditionsUrl: jsonData['termsAndConditionsUrl'],
        finishText: jsonData['finishText'],
        startedAt: jsonData['startedAt'],
        endedAt: jsonData['endedAt'],
        surveyQuestions: jsonData.containsKey(
                'questions') // to get list of SurveyQuestion object
            ? (jsonData['questions'] as List<dynamic>)
                .map((e) => SurveyQuestion.fromJson(e))
                .toList()
            : []);
  }

  String id;
  String title, description, imageUrl, termsAndConditionsUrl, finishText;
  String? startedAt, endedAt;
  List<SurveyQuestion> surveyQuestions;
}

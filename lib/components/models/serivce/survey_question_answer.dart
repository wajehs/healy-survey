class SurveyQuestionAnswer {
  SurveyQuestionAnswer({required this.text, required this.value});

  // to create SurveyQuestionAnswer objec from decoded json data
  static SurveyQuestionAnswer fromJson(Map<String, dynamic> jsonData) {
    return SurveyQuestionAnswer(
        text: jsonData['text'], value: jsonData['value']);
  }

  String text;
  int value;
}

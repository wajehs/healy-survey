import 'package:flutter/material.dart';
import 'package:healy_survey/components/constant/style/survey_question.dart';
import 'package:healy_survey/components/models/serivce/survey_question_answer.dart';

class CustomRadioButtonWithTextWidget extends StatelessWidget {
  final Function(int?)? onClickAction;
  final int? groupValue;
  final SurveyQuestionAnswer answer;
  const CustomRadioButtonWithTextWidget({
    Key? key,
    this.groupValue,
    required this.answer,
    this.onClickAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 75,
        child: Column(
          children: [
            Radio(
                value: answer.value,
                groupValue: groupValue,
                onChanged: onClickAction),
            Text(
              answer.text,
              style: selectStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}

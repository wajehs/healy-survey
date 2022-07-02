import 'package:flutter/material.dart';
import 'package:healy_survey/components/constant/style/survey_question.dart';

class CustomCheckBoxWithTextWidget extends StatelessWidget {
  final bool isChecked;
  final Function(bool?)? onClickAction;
  final String text;
  const CustomCheckBoxWithTextWidget({
    Key? key,
    required this.isChecked,
    required this.text,
    this.onClickAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height:55,
        decoration: selectContainerStyle,
        child: Row(
          children: [
            Expanded(child: Text(text, style: selectStyle)),
            Checkbox(value: isChecked, onChanged: onClickAction),
          ],
        ));
  }
}

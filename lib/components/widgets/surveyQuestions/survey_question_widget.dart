import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healy_survey/components/bloc/survey_bloc.dart';
import 'package:healy_survey/components/constant/style/home.dart';
import 'package:healy_survey/components/constant/style/survey_question.dart';
import 'package:healy_survey/components/models/serivce/survey.dart';
import 'package:healy_survey/components/models/serivce/survey_question.dart';
import 'package:healy_survey/components/models/serivce/survey_question_answer.dart';
import 'package:healy_survey/components/widgets/common/buttons/custom_text_button.dart';
import 'package:healy_survey/components/widgets/common/checkbox/custom_checkbox_with_text_widget.dart';
import 'package:healy_survey/components/widgets/common/inputField/custom_input_field_widget.dart';
import 'package:healy_survey/components/widgets/common/listView/grid_item_list_widget.dart';
import 'package:healy_survey/components/widgets/common/radioButton/custom_radio_button_with_text_widget.dart';

class SurveyQuestionWidget extends StatelessWidget {
  final SurveyQuestion surveyQuestion;
  final TextEditingController controller;
  final Function()? onNextAction;
  final Function(bool?, SurveyQuestionAnswer, bool) onselectAction;
  final Function(dynamic) onChangeAnswer;
  final int questionIndex;
  const SurveyQuestionWidget(
      {Key? key,
      required this.controller,
      required this.surveyQuestion,
      required this.questionIndex,
      required this.onselectAction,
      required this.onChangeAnswer,
      this.onNextAction})
      : super(key: key);

  Widget _buildInfo(BuildContext context) {
    final Survey surveyData = BlocProvider.of<SurveyDataBloc>(context).state;

    return Column(children: [
      Expanded(
          child: ListView(shrinkWrap: true, children: [
        Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              surveyQuestion.text,
              style: questionTextStyle,
            )),
        if (surveyQuestion.type == 'multiple')
          const Text(
            '(Multiple answers are allowed)',
            textAlign: TextAlign.center,
          ),
        if (surveyQuestion.type == 'text')
          Padding(
              padding: const EdgeInsets.all(20),
              child: CustomInputFieldWidget(
                autoFocus: true,
                controller: controller,
                maxLine: 10,
                onChangeText: onChangeAnswer,
              )),
        if (surveyQuestion.type == 'single' ||
            surveyQuestion.type == 'multiple')
          ListView.builder(
              itemCount: surveyQuestion.answers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int index) {
                return CustomCheckBoxWithTextWidget(
                  isChecked: surveyQuestion.questionAnswer != null &&
                      ((surveyQuestion.questionAnswer is int &&
                              surveyQuestion.questionAnswer ==
                                  surveyQuestion.answers[index].value) ||
                          (surveyQuestion.questionAnswer is List &&
                              (surveyQuestion.questionAnswer as List).contains(
                                  surveyQuestion.answers[index].value))),
                  text: surveyQuestion.answers[index].text,
                  onClickAction: (bool? status) => onselectAction(
                      status,
                      surveyQuestion.answers[index],
                      (surveyQuestion.type == 'multiple')),
                );
              }),
        if (surveyQuestion.type == 'rating')
          Padding(
              padding: const EdgeInsets.all(20),
              child: GridItemListWidget(
                  customItemWidth: 75,
                  childAspectRatio: 0.5,
                  widgetList: surveyQuestion.answers
                      .map(((e) => CustomRadioButtonWithTextWidget(
                            answer: e,
                            groupValue: surveyQuestion.questionAnswer,
                            onClickAction: onChangeAnswer,
                          )))
                      .toList())),
      ])),
      SizedBox(
          height: 100,
          child: DotsIndicator(
            position: questionIndex.toDouble(),
            dotsCount: surveyData.surveyQuestions.length,
            decorator: dotsDecorator,
          )),
      CustomTextButton(
        text: 'Next',
        onTapAction: (surveyQuestion.isRequired &&
                (surveyQuestion.questionAnswer == null ||
                    (surveyQuestion.questionAnswer is String &&
                        surveyQuestion.questionAnswer.isEmpty) ||
                    (surveyQuestion.questionAnswer is List &&
                        surveyQuestion.questionAnswer.isEmpty)))
            ? null
            : onNextAction,
      ),
      const SizedBox(height: 10)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildInfo(context);
  }
}

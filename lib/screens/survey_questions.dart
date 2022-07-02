import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healy_survey/components/bloc/survey_bloc.dart';
import 'package:healy_survey/components/models/serivce/survey.dart';
import 'package:healy_survey/components/models/serivce/survey_question_answer.dart';
import 'package:healy_survey/components/pageTransition/custom_page_transition.dart';
import 'package:healy_survey/components/widgets/surveyQuestions/survey_question_widget.dart';
import 'package:healy_survey/screens/survey_completed.dart';

class SurveyQuestions extends StatefulWidget {
  final int questionIndex;
  const SurveyQuestions({
    Key? key,
    required this.questionIndex,
  }) : super(key: key);
  @override
  SurveyQuestionsState createState() => SurveyQuestionsState();
}

class SurveyQuestionsState extends State<SurveyQuestions> {
  final TextEditingController _inputController = TextEditingController();
  @override
  void initState() {
    _loadAnswer();
    super.initState();
  }

// to auto load existing text answer
  void _loadAnswer() {
    if (BlocProvider.of<SurveyDataBloc>(context)
        .state
        .surveyQuestions[widget.questionIndex]
        .questionAnswer is String) {
      setState(() {
        _inputController.text = BlocProvider.of<SurveyDataBloc>(context)
            .state
            .surveyQuestions[widget.questionIndex]
            .questionAnswer;
      });
    }
  }

// to navigate to next question or to complete survey
  void _onNextAction(Survey surveyData) {
    Navigator.push(
        context,
        CustomPageTransitionRoute(
          page: ((widget.questionIndex + 1) < surveyData.surveyQuestions.length)
              ? SurveyQuestions(questionIndex: widget.questionIndex + 1)
              : const SurverCompleted(),
        ));
  }

// to change the answer for multiselect and select questions
  void _onselectAction(
      bool? answerStatus, SurveyQuestionAnswer answer, bool isMultiSelect) {
    if (BlocProvider.of<SurveyDataBloc>(context)
            .state
            .surveyQuestions[widget.questionIndex]
            .questionAnswer ==
        null) {
      if (answerStatus != null && answerStatus) {
        if (isMultiSelect) {
          setState(() {
            BlocProvider.of<SurveyDataBloc>(context)
                .state
                .surveyQuestions[widget.questionIndex]
                .questionAnswer = [answer.value];
          });
        } else {
          setState(() {
            BlocProvider.of<SurveyDataBloc>(context)
                .state
                .surveyQuestions[widget.questionIndex]
                .questionAnswer = answer.value;
          });
        }
      }
    } else {
      if (answerStatus != null && answerStatus) {
        if (isMultiSelect) {
          setState(() {
            BlocProvider.of<SurveyDataBloc>(context)
                .state
                .surveyQuestions[widget.questionIndex]
                .questionAnswer
                .add(answer.value);
          });
        } else {
          setState(() {
            BlocProvider.of<SurveyDataBloc>(context)
                .state
                .surveyQuestions[widget.questionIndex]
                .questionAnswer = answer.value;
          });
        }
      } else if (answerStatus != null && !answerStatus) {
        if (isMultiSelect) {
          setState(() {
            BlocProvider.of<SurveyDataBloc>(context)
                .state
                .surveyQuestions[widget.questionIndex]
                .questionAnswer
                .remove(answer.value);
          });
        } else {
          setState(() {
            BlocProvider.of<SurveyDataBloc>(context)
                .state
                .surveyQuestions[widget.questionIndex]
                .questionAnswer = null;
          });
        }
      }
    }
  }

// to change the answer for text and rating type questions
  void _onChangeAnswer(dynamic value) {
    setState(() {
      BlocProvider.of<SurveyDataBloc>(context)
          .state
          .surveyQuestions[widget.questionIndex]
          .questionAnswer = value;
    });
  }

// build widget for rendering
  Widget _buildInfo(BuildContext context, Survey surveyData) {
    return SurveyQuestionWidget(
      controller: _inputController,
      questionIndex: widget.questionIndex,
      surveyQuestion: surveyData.surveyQuestions[widget.questionIndex],
      onNextAction: () => _onNextAction(surveyData),
      onChangeAnswer: _onChangeAnswer,
      onselectAction: _onselectAction,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Survey surveyData = BlocProvider.of<SurveyDataBloc>(context).state;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          centerTitle: true,
          title: Text(
            'SURVEY ${(widget.questionIndex + 1)}/${surveyData.surveyQuestions.length.toString()}',
          ),
        ),
        body: _buildInfo(context, surveyData));
  }
}

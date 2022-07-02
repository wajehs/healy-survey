import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healy_survey/components/bloc/survey_bloc.dart';
import 'package:healy_survey/components/models/serivce/survey.dart';
import 'package:healy_survey/components/pageTransition/custom_page_transition.dart';
import 'package:healy_survey/components/widgets/home/survey_home_widget.dart';
import 'package:healy_survey/screens/survey_questions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool _isConsentAcccepted = false;
  @override
  void initState() {
    super.initState();
  }

  // to navigate to questionsscreen
  void _onSurveyStartAction() {
    Navigator.push(
        context,
        CustomPageTransitionRoute(
          page: const SurveyQuestions(questionIndex: 0),
        ));
  }

// build widget for rendering
  Widget _buildInfo(BuildContext context) {
    final Survey surveyData = BlocProvider.of<SurveyDataBloc>(context).state;
    return SurveyHomeWidget(
      surveyData: surveyData,
      isConsentAcccepted: _isConsentAcccepted,
      onSurveyStartAction: _onSurveyStartAction,
      onConsentAction: (bool? value) => setState(() {
        _isConsentAcccepted = value!; // to enable survey start
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'SURVEY',
          ),
        ),
        body: _buildInfo(context));
  }
}

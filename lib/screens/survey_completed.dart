import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healy_survey/components/bloc/survey_bloc.dart';
import 'package:healy_survey/components/constant/style/survey_question.dart';
import 'package:healy_survey/components/models/serivce/survey.dart';
import 'package:healy_survey/components/utilities/image_utility.dart';
import 'package:healy_survey/components/utilities/route_utility.dart';
import 'package:healy_survey/components/widgets/common/buttons/custom_text_button.dart';

class SurverCompleted extends StatelessWidget {
  const SurverCompleted({Key? key}) : super(key: key);

// build widget for rendering
  Widget _buildInfo(BuildContext context) {
    final Survey surveyData = BlocProvider.of<SurveyDataBloc>(context).state;
    return SafeArea(
      child: Column(children: [
        Expanded(
            child: ListView(
          children: [
            ImageUtility.getSurveyImage(surveyData.imageUrl, BoxFit.fill),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        surveyData.finishText,
                        style: successTextStyle,
                      ),
                      const SizedBox(height: 15),
                    ]))
          ],
        )),
        CustomTextButton(
          text: 'Close',
          onTapAction: () {
            RouteUtility.changeMainRouteNamed(context, '/home'); // to navigate to home
          },
        ),
        const SizedBox(height: 10),
      ]),
    );
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              leading: const SizedBox(),
              title: const Text(
                'SURVEY COMPLETED',
              ),
              actions: const [
                Icon(
                  Icons.done,
                  color: Color(0xff30bb8f),
                ),
                SizedBox(width: 20)
              ],
            ),
            body: _buildInfo(context)));
  }
}

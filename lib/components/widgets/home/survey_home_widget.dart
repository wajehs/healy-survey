import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:healy_survey/components/constant/style/home.dart';
import 'package:healy_survey/components/models/serivce/survey.dart';
import 'package:healy_survey/components/utilities/image_utility.dart';
import 'package:healy_survey/components/utilities/url_utility.dart';
import 'package:healy_survey/components/widgets/common/buttons/custom_text_button.dart';

class SurveyHomeWidget extends StatelessWidget {
  final Survey surveyData;
  final bool isConsentAcccepted;
  final Function(bool?)? onConsentAction;
  final Function() onSurveyStartAction;

  const SurveyHomeWidget(
      {Key? key,
      required this.surveyData,
      required this.isConsentAcccepted,
      required this.onConsentAction,
      required this.onSurveyStartAction})
      : super(key: key);

  Widget _buildInfo(BuildContext context) {
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
                      surveyData.title,
                      style: surveyTitleStyle,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      surveyData.description,
                      style: surveyDescriptionStyle,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Checkbox(
                            key: const Key('consent'),
                            value: isConsentAcccepted,
                            onChanged: onConsentAction),
                        Expanded(
                            child: RichText(
                                text: TextSpan(children: [
                          const TextSpan(
                              style: constentTextStyle,
                              text: "I've read and and accept the "),
                          TextSpan(
                              style: constentLinkStyle,
                              text: 'Terms and Conditions',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => UrlUtility.launchURL(
                                    surveyData.termsAndConditionsUrl, context)),
                        ])))
                      ],
                    ),
                    const SizedBox(height: 40),
                  ]))
        ],
      )),
      CustomTextButton(
        text: 'Start',
        onTapAction: isConsentAcccepted ? onSurveyStartAction : null,
      ),
      const SizedBox(height: 10),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildInfo(context);
  }
}

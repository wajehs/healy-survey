import 'package:flutter/material.dart';
import 'package:healy_survey/components/constant/style/home.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function()? onTapAction;
  const CustomTextButton({Key? key, required this.text, this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTapAction,
              child: Text(text, style: buttonTextStyle),
            )));
  }
}

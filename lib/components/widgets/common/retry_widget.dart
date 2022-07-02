import 'package:flutter/material.dart';
import 'package:healy_survey/components/constant/style/common.dart';

class RetryWidget extends StatelessWidget {
  final String text;
  final Function(BuildContext) onRetry;

  const RetryWidget({Key? key, required this.text, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => onRetry(context),
                icon: const Icon(Icons.refresh)),
            Text(
              text,
              style: reloadTextStyle,
            ),
          ])
    ]);
  }
}

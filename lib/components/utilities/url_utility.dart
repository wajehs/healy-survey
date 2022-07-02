import 'package:flutter/material.dart';
import 'package:healy_survey/components/utilities/snackbar_utility.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtility {
  // to launch  url from App
  static void launchURL(String url, BuildContext context) async {
    try {
      if (!await launchUrl(
        Uri.parse(url),
      )) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      SnackbarUtility.publishMessage(e.toString(), context);
    }
  }
}

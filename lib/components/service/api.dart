import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:healy_survey/components/models/serivce/survey.dart';

class Api {
  final http.Client client;

  Api(this.client);
  // to retrieve survey data
  Future<Survey> getSurveyData() async {
    try {
      final response = await client.get(Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/healy-identity.appspot.com/o/polls%2FvAJax5hdbF.json?alt=media&token=48258028-2f77-493d-9e9d-8ca322b3068a'));
      if (response.statusCode == 200) {
        return Survey.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw HttpException(jsonDecode(response.body));
      }

      throw ('Something went wrong...');
    } on SocketException {
      throw 'Check internet...';
    } catch (e) {
      rethrow;
    }
  }
}

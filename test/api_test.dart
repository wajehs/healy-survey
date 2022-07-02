// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:healy_survey/components/service/api.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  // Api test case with local data
  test('Api test', () async {
    Future<http.Response> _mockRequest(http.Request request) async {
      if (request.url.toString().contains(
          'https://firebasestorage.googleapis.com/v0/b/healy-identity.appspot.com/o/polls%2FvAJax5hdbF.json?alt=media&token=48258028-2f77-493d-9e9d-8ca322b3068a')) {
        return http.Response(
            File('test/test_resources/test.json').readAsStringSync(), 200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }
      return http.Response('Error: Unknown endpoint', 404);
    }

    final apiProvider = Api(MockClient(_mockRequest));

    final survey = await apiProvider.getSurveyData();
    expect(survey.id, 'vAJax5hdbF');
    expect(survey.title, "Effects of the Healy on human emotions");
    expect(
      survey.imageUrl,
      'https://firebasestorage.googleapis.com/v0/b/healy-identity.appspot.com/o/polls%2FvAJax5hdbF.jpg?alt=media&token=4217d7e6-e855-47dc-a55e-8c692668a6ba',
    );
  });
}

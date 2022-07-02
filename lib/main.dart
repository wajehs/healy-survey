import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healy_survey/components/bloc/survey_bloc.dart';
import 'package:healy_survey/components/constant/common/color_constants.dart';
import 'package:healy_survey/components/models/serivce/survey.dart';
import 'package:healy_survey/components/service/api.dart';
import 'package:healy_survey/components/utilities/route_utility.dart';
import 'package:healy_survey/components/widgets/common/common_loader_widget.dart';
import 'package:healy_survey/components/widgets/common/retry_widget.dart';
import 'package:healy_survey/screens/home.dart'; 
import 'package:http/http.dart' as http;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

// possible routes
  Map<String, WidgetBuilder> _routes() {
    return {
      '/home': (BuildContext context) => const App(),
    };
  }

  /// Returns the Survey Data from fiebase url
  Future<Survey?> _getSurveyData(BuildContext context) async {
    try {
      http.Client client = http.Client();
      return await Api(client).getSurveyData();
    } catch (e) {
      return null;
    }

    // return null if any exception occurs
  }

  // build widget for rendering
  Widget _buildApp(BuildContext context, Survey surveyData) {
    return MaterialApp(
      title: 'Healy flutter task',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black54),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 18)),
          checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(Colors.white),
            fillColor: MaterialStateProperty.all(themeButtonColor),
            side: const BorderSide(color: Colors.grey),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          ),
          radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.all(themeButtonColor),
              overlayColor: MaterialStateProperty.all(Colors.white)),
          buttonTheme: const ButtonThemeData(buttonColor: themeButtonColor),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  )),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return themeButtonColor.withOpacity(0.5);
                      } else if (states.contains(MaterialState.disabled)) {
                        return themeButtonColor.withOpacity(0.2);
                      }
                      return themeButtonColor; // Use the component's default.
                    },
                  )))),
      home: const Home(),
      debugShowCheckedModeBanner: false,
      routes: _routes(),
    );
  }

  /// Returns a bloc provider with the survey Data
  Widget _buildBlocProvider(Survey? surveyData, BuildContext context) {
    if (surveyData != null) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<SurveyDataBloc>(
            create: (BuildContext context) => SurveyDataBloc(surveyData),
          ),
        ],
        child: BlocBuilder<SurveyDataBloc, Survey>(
          builder: (c, state) {
            return _buildApp(c, surveyData);
          },
        ),
      );
    }
    // to render retry widget on data error
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RetryWidget(
          text: 'No data available',
          onRetry: _onRetry,
        ),
      ),
      routes: _routes(),
    );
  }

// for building widget with bloc
  Future<Widget> _settingsBuilder(BuildContext context) async {
    return _buildBlocProvider(await _getSurveyData(context), context);
  }

// to reload home
  void _onRetry(BuildContext context) async {
    RouteUtility.changeMainRouteNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _settingsBuilder(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasError) return snapshot.data;
        } else if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(body: CommonLoaderWidget()));
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: RetryWidget(
              text: 'No data available',
              onRetry: _onRetry,
            ),
          ),
          routes: _routes(),
        );
      },
    );
  }
}

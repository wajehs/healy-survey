import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healy_survey/components/models/serivce/survey.dart';

class SurveyDataBloc extends Cubit<Survey> {
  SurveyDataBloc(Survey authData) : super(authData);

  /// Change the current survey Data informartion
  void setSurveyDataBloc(Survey authData) => emit(authData);
}

import 'package:istchrat/screens/teacher/teacher_waiting/delay_screen/DelayDateModel.dart';

abstract class LogsStates{}

class LogsInitialStates extends LogsStates{}

class GetLogsCategoriesSuccessfully extends LogsInitialStates{}

class GetLogsCategoriesError extends LogsInitialStates{}

class GetLogsItemSuccess extends LogsInitialStates{}

class GetLogsItemError extends LogsInitialStates{}

class GetMoreLogsLoading extends LogsStates{}
class GetMoreLogsSuccess extends LogsStates{}
class GetMoreLogsError extends LogsStates{}

class CheckSelectedTapState extends LogsInitialStates{}

class AcceptedSuccessfullyState extends LogsInitialStates{
  String message;
AcceptedSuccessfullyState(this.message);
}

class AcceptedErrorState extends LogsInitialStates{
  final String errorMsg;

  AcceptedErrorState(this.errorMsg);
}

class AcceptedLoadingState extends LogsInitialStates{}

class GetDelayDateState extends LogsInitialStates{}
class DelayDateErrorState extends LogsInitialStates{}

class GetDelayDateByMonth extends LogsInitialStates{
  Months month;
  GetDelayDateByMonth(this.month);
}

class GetDelayDateByDay extends LogsInitialStates{
}

class CheckDaySelectedIndex extends LogsInitialStates{}
class CheckTimeSelectedIndex extends LogsInitialStates{}
class CheckMonthSelectedIndex extends LogsInitialStates{}
class ItemsSearchState extends LogsInitialStates{
  int length;
  ItemsSearchState(this.length);
}

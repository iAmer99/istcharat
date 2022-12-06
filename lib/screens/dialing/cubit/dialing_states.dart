abstract class DialingStates {}
class DialingInitialState extends DialingStates {}

abstract class DialingLecturerStates extends DialingStates {}
class DialingCallStartingState extends DialingLecturerStates {}
class DialingCallStartedState extends DialingLecturerStates {}
class DialingCallFailedState extends DialingLecturerStates {
  final String errorMsg;

  DialingCallFailedState(this.errorMsg);

}
class DialingCallEndedState extends DialingLecturerStates {}

abstract class DialingStudentStates extends DialingStates {}
class DialingIncomingCallState extends DialingStudentStates {}
class DialingAcceptedState extends DialingStudentStates {}
class DialingRejectedState extends DialingStudentStates {}
abstract class ChatStates{}

class ChatInitialStates extends ChatStates{}

class ChatStartingState extends ChatStates {}

class ChatStartedState extends ChatStates {
  final String period;

  ChatStartedState(this.period);
}

class ChatFailedState extends ChatStates {
  final String error;

  ChatFailedState(this.error);
}
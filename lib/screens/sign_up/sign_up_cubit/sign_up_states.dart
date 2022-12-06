abstract class SignUpStates{}

class SignUpInitialState extends SignUpStates{}

class SignUpSuccessState extends SignUpInitialState{
  String message;

  SignUpSuccessState(this.message);
}

class SignUpErrorState extends SignUpInitialState{
  final String errorMsg;

  SignUpErrorState(this.errorMsg);
}

class LoadingState extends SignUpInitialState{}
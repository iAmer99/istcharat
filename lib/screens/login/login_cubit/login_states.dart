abstract class LoginStates{}

class LoginInitialStates extends LoginStates{}

class LoginSuccessState extends LoginInitialStates{}

class LoginErrorState extends LoginInitialStates{}

class WrongUserState extends LoginInitialStates{
  final String errorMsg;

  WrongUserState(this.errorMsg);
}

class LoadingState extends LoginInitialStates{}


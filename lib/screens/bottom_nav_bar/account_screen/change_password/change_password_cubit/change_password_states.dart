abstract class ChangePasswordStates{}

class ChangePasswordInitialStates extends ChangePasswordStates{}

class LoadingState extends ChangePasswordStates{}

class ChangePasswordSuccess extends ChangePasswordInitialStates{
  String message;
  ChangePasswordSuccess(this.message);
}

class ChangePasswordFailed extends ChangePasswordInitialStates{
  final String msg;

  ChangePasswordFailed(this.msg);
}
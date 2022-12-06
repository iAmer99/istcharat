abstract class ForgetPasswordState{}

class ForgetPasswordInitialStates extends ForgetPasswordState{}

class ForgetPasswordSuccess extends ForgetPasswordInitialStates{
  final String message;

  ForgetPasswordSuccess(this.message);
}

class ForgetPasswordFailed extends ForgetPasswordInitialStates{
  final String errorMsg;

  ForgetPasswordFailed(this.errorMsg);
}

class LoadingState extends ForgetPasswordInitialStates{}

class ResentCodeSuccessfully extends ForgetPasswordState {
  final String msg;

  ResentCodeSuccessfully(this.msg);
}

class ResentCodeError extends ForgetPasswordState {
  final String errorMSG;

  ResentCodeError(this.errorMSG);
}
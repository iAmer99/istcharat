abstract class ConfirmationStates {}

class ConfirmationInitialState extends ConfirmationStates {}

class ConfirmationDetailsLoadingState extends ConfirmationStates {}

class ConfirmationDataSuccessState extends ConfirmationStates {}

class ConfirmationDataErrorState extends ConfirmationStates {
  final String error;

  ConfirmationDataErrorState(this.error);
}

class ConfirmLoadingState extends ConfirmationStates {}

class ConfirmSuccessState extends ConfirmationStates {
  final String url;
  final String msg;
  ConfirmSuccessState({required this.url, required this.msg});
}

class WalletConfirmSuccessState extends ConfirmationStates {
  final String msg;
  WalletConfirmSuccessState({required this.msg});
}

class ConfirmErrorState extends ConfirmationStates {
  final String error;

  ConfirmErrorState(this.error);
}

class CheckCouponSuccess extends ConfirmationStates{
  String message;
  CheckCouponSuccess(this.message);
}

class CheckCouponError extends ConfirmationStates{
  String message;
  CheckCouponError(this.message);
}
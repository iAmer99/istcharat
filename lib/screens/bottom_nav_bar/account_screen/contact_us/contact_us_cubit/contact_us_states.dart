abstract class ContactUsStates{}

class ContactUsInitialStates extends ContactUsStates{}

class ContactUsSuccess extends ContactUsInitialStates{
  String message;
  ContactUsSuccess(this.message);
}

class ContactUsError extends ContactUsInitialStates{
  final String error;

  ContactUsError(this.error);
}

class LoadingState extends ContactUsInitialStates{}
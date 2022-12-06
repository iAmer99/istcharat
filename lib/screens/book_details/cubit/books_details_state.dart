class BooksDetailsState {}

class BooksDetailsInitial extends BooksDetailsState {}

class BooksDetailsLoading extends BooksDetailsState {}

class BooksDetailsSuccess extends BooksDetailsState {}

class BooksDetailsError extends BooksDetailsState {
  final String error;

  BooksDetailsError(this.error);
}


class RemovedFromFavSuccess extends BooksDetailsState {}
class AddedToFavSuccess extends BooksDetailsState {}

class BuyLoadingState extends BooksDetailsState {}
class BuySuccessState extends BooksDetailsState {
  final String message;
  final String id;
  BuySuccessState({required this.message, required this.id});
}
class BuyErrorState extends BooksDetailsState {
  final String error;

  BuyErrorState(this.error);
}

class FreeBuySuccessState extends BooksDetailsState {
  final String message;

  FreeBuySuccessState({required this.message,});
}
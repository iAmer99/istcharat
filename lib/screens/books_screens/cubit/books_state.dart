class BooksState {}

class BooksInitial extends BooksState {}

class BooksSuccess extends BooksState {}

class BooksLoading extends BooksState {}

class BooksError extends BooksState {
  final String error;

  BooksError(this.error);
}

class AddMyBookToFavSuccess extends BooksState {}

class AddMyBookToFavError extends BooksState {
  final String error;

  AddMyBookToFavError(this.error);
}

class RemovMyBookFromFavSuccess extends BooksState {}

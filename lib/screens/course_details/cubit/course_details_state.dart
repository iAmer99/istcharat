abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsSuccess extends CourseDetailsState {}

class CourseDetailsError extends CourseDetailsState {
  final String error;

  CourseDetailsError(this.error);
}

class RemovedFromFavSuccess extends CourseDetailsState {}
class AddedToFavSuccess extends CourseDetailsState {}

class BuyLoadingState extends CourseDetailsState {}
class BuySuccessState extends CourseDetailsState {
  final String message;
  final String id;

  BuySuccessState({required this.message, required this.id});

}
class BuyErrorState extends CourseDetailsState {
  final String error;

  BuyErrorState(this.error);
}

class FreeBuySuccessState extends CourseDetailsState {
  final String message;

  FreeBuySuccessState({required this.message});

}

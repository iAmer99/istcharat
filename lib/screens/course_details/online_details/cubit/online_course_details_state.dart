class OnlineCourseDetailsState {}

class OnlineCourseDetailsInitial extends OnlineCourseDetailsState {}

class OnlineCourseDetailsLoading extends OnlineCourseDetailsState {}

class OnlineCourseDetailsSuccess extends OnlineCourseDetailsState {}

class OnlineCourseDetailsError extends OnlineCourseDetailsState {
  final String error;

  OnlineCourseDetailsError(this.error);
}

class RemovedFromFavSuccess extends OnlineCourseDetailsState {}
class AddedToFavSuccess extends OnlineCourseDetailsState {}

class OnlineCourseBuyLoadingState extends OnlineCourseDetailsState {}
class OnlineCourseBuySuccessState extends OnlineCourseDetailsState {
  final String message;
  final String id;

  OnlineCourseBuySuccessState({required this.message, required this.id});

}
class OnlineCourseBuyErrorState extends OnlineCourseDetailsState {
  final String error;

  OnlineCourseBuyErrorState(this.error);
}

class OnlineCourseFreeBuySuccessState extends OnlineCourseDetailsState {
  final String message;

  OnlineCourseFreeBuySuccessState({required this.message,});

}

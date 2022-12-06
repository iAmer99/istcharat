abstract class FavouritesStates {}

class FavouritesInitialState extends FavouritesStates {}

// Books
class FavouritesBooksStates extends FavouritesStates {}
class FavouriteBooksLoadingState extends FavouritesBooksStates {}
class FavouriteBooksSuccessState extends FavouritesBooksStates {}
class FavouriteBooksErrorState extends FavouritesBooksStates {
  final String error;

  FavouriteBooksErrorState({required this.error});
}
class FavouriteBooksDeleteState extends FavouritesBooksStates {}

//Recorded Courses
class FavouritesRecordedCoursesStates extends FavouritesStates {}
class FavouriteRecordedCoursesLoadingState extends FavouritesRecordedCoursesStates {}
class FavouriteRecordedCoursesSuccessState extends FavouritesRecordedCoursesStates {}
class FavouriteRecordedCoursesErrorState extends FavouritesRecordedCoursesStates {
  final String error;

  FavouriteRecordedCoursesErrorState({required this.error});
}
class FavouriteRecordedCoursesDeleteState extends FavouritesRecordedCoursesStates {}

// Online Courses
class FavouritesOnlineCoursesStates extends FavouritesStates {}
class FavouriteOnlineCoursesLoadingState extends FavouritesOnlineCoursesStates {}
class FavouriteOnlineCoursesSuccessState extends FavouritesOnlineCoursesStates {}
class FavouriteOnlineCoursesErrorState extends FavouritesOnlineCoursesStates {
  final String error;

  FavouriteOnlineCoursesErrorState({required this.error});
}
class FavouriteOnlineCoursesDeleteState extends FavouritesOnlineCoursesStates {}

class RemovedFromFavSuccess extends FavouritesStates {}
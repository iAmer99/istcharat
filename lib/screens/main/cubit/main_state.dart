class MainState {
}
class MainInitial extends MainState{}
class MainLoading extends MainState{}
class MainSuceess extends MainState{}
class MainError extends MainState{
  final String error;
  MainError(this.error);
}

class AddedToFavSuccess extends MainState {}
class RemovedFromFavSuccess extends MainState {}
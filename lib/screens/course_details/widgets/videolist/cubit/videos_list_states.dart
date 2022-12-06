abstract class VideosListStates {}

class VideosListInitialState extends VideosListStates {}

class VideosListLoadingState extends VideosListStates {}

class VideosListSuccessState extends VideosListStates {}

class VideosListErrorState extends VideosListStates {
  final String msg;

  VideosListErrorState(this.msg);
}
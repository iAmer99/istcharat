class OnlineState {}
class OnlineStateInitial extends OnlineState{}
class OnlineStateLoading extends OnlineState{}
class OnlineStateSucess extends OnlineState{}
class OnlineStateError extends OnlineState{
  final String error;

  OnlineStateError(this.error);

}
class AddedMyOnlineToFavSuccess extends OnlineState {}
class RemoveMyOnlineFav extends OnlineState{}
class RecordedState {}

class RecordedStateInitial extends RecordedState {}

class RecordedStateLoading extends RecordedState {}

class RecordedStateSucess extends RecordedState {}

class RecordedStateError extends RecordedState {
  final String error;

  RecordedStateError(this.error);
}

class AddRecordedToFavSuccess extends RecordedState {}

class AddRecordedToFavError extends RecordedState {
  final String error;

  AddRecordedToFavError(this.error);
}

class RemovedRecordedFromFavSuccess extends RecordedState {}

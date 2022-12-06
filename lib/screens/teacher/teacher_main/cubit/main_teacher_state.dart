class MainTeacherState {}
class MainTeacherInitial extends MainTeacherState{}
class MainTeacherLoading extends MainTeacherState{}
class MainTeacherSucess extends MainTeacherState{}
class MainTeacherFail extends MainTeacherState{
  final String error;

  MainTeacherFail(this.error);

}
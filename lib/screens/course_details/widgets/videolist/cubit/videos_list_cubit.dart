import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/cubit/videos_list_states.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/repository/model/video_list_model.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/repository/vidoes_list_repository.dart';

class VideosListCubit extends Cubit<VideosListStates> {
  VideosListCubit() : super(VideosListInitialState());
  static VideosListCubit get(BuildContext context) => BlocProvider.of<VideosListCubit>(context);
  final VideosListRepository _repository = VideosListRepository();
  List<VideosList> list = [];

  Future getList({required String segment, required String id}) async{
    emit(VideosListLoadingState());
    final response = await _repository.getVideosList(segment: segment, id: id);
    response.fold((error){
      emit(VideosListErrorState(error));
    }, (data){
      list = data;
      emit(VideosListSuccessState());
    });
  }
}
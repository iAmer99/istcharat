import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/teacher/logs/cubit/logs_states.dart';
import 'package:istchrat/screens/teacher/logs/repo/LogsCategoriesModel.dart';
import 'package:istchrat/screens/teacher/logs/repo/LogsItemsModel1.dart';
import 'package:istchrat/screens/teacher/logs/repo/logs_repo.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/delay_screen/DelayDateModel.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/repo/AcceptOrDeclineModel.dart';

class LogsCubit extends Cubit<LogsStates>{

  LogsCubit() :super(LogsInitialStates());

  static LogsCubit get(context)=> BlocProvider.of(context);

  LogsRepo logsRepo = LogsRepo();
  LogsCategoriesModel? logsCategoriesModel;
  bool isLoading = true;
  bool logsItemsLoading = true;
  LogsItemsModel1? itemModel;
  int selectedTap = 0;
  AcceptOrDeclineModel? acceptOrDeclineModel;
  bool delayLoading = true;
  DelayDateModel? dateModel;
  Months? selectedMonth;
  int selectedIndex = 0;
  int timeSelectedIndex = 0;
  int searchListLength = 0;
  List<items>? searchData = <items>[];
  List<items>? itemsList = [];
  bool isError = false;
  bool lastPaginatePage = false;
  int paginatePage = 1;


      getLogsCategories({int index = 0}) async {
    try{
      isLoading = true;
      isError = false;
      logsCategoriesModel = await logsRepo.getLogsCategories();
      print(logsCategoriesModel!.data!.rows![0].key);
      getLogsItems(logsCategoriesModel!.data!.rows![index].key.toString(),"","","pending");
      emit(GetLogsCategoriesSuccessfully());
    }
    catch(e){
      print(e);
      isLoading = false;
      isError = true;
      emit(GetLogsCategoriesError());
    }
  }

  getLogsItems(String categoryKey,String fromDate,String toDate,String statusKey) async {
    try{
      paginatePage = 1;
      lastPaginatePage = false;
      logsItemsLoading = true;
      isError = false;
      itemModel = await logsRepo.getLogsItems(categoryKey,fromDate,toDate,statusKey, paginatePage: 1);
      itemsList = itemModel!.data!.rows!;
      isLoading = false;
      logsItemsLoading = false;
      if(itemModel?.data?.paginate?.currentPage == itemModel?.data?.paginate?.lastPage){
        lastPaginatePage = true;
      }
      emit(GetLogsItemSuccess());
    }
    catch(e){
      print(e);
      isLoading = false;
      isError = true;
      logsItemsLoading = false;
      emit(GetLogsItemError());
    }
  }

  getMoreLogsItems(String categoryKey,String fromDate,String toDate,String statusKey) async{
    try{
      paginatePage = paginatePage + 1;
      final LogsItemsModel1? data = await logsRepo.getLogsItems(categoryKey,fromDate,toDate,statusKey, paginatePage: paginatePage);
      if(data?.data?.paginate?.currentPage == data?.data?.paginate?.lastPage){
        lastPaginatePage = true;
        paginatePage = 1;
      }
      if(data?.data?.rows != null){
        itemsList?.addAll(data!.data!.rows!);
        itemModel?.data?.rows?.addAll(data!.data!.rows!);
      }
      itemModel?.data?.setPaginate = data?.data?.paginate;
      emit(GetMoreLogsSuccess());
    }
    catch(e){
      print(e.toString() + "check");
      emit(GetMoreLogsError());
    }
  }

  checkSelectedTap(int index) {
      selectedTap = index;
    emit(CheckSelectedTapState());
  }


  acceptOrDecline(String categoryKey,String id,String status, String rejectReason,String delayedDate,
      String delayedTime,String statusKey,String answer) async {
        print(delayedDate);
    try{
      emit(AcceptedLoadingState());
      final response = await logsRepo.acceptOrDecline(categoryKey,id,status,rejectReason,delayedDate,delayedTime,answer);
      response.fold((error){
        emit(AcceptedErrorState(error));
      }, (data){
        acceptOrDeclineModel = data;
            print(acceptOrDeclineModel!.data!.message);
        getLogsItems(categoryKey, '', '', statusKey);
        emit(AcceptedSuccessfullyState(acceptOrDeclineModel!.data!.message.toString()));
      });
    }
    catch(e){
      print(e);
      emit(AcceptedErrorState("unknown_error".tr));
    }
  }

  getDelayDate(String month, String period,String categoryKey) async {
    try{
      delayLoading = true;
      dateModel = await logsRepo.getDelayDate(month: month, period: period, categoryKey: categoryKey);
      print(dateModel!.data!.months![0].value);
      print(dateModel!.data!.months![0].value);
      selectedMonth = dateModel!.data!.months![0];
      delayLoading = false;
      emit(GetDelayDateState());
    }
    catch(e){
      print(e.toString());
      delayLoading = false;
      emit(DelayDateErrorState());
    }
  }

  getDelayDateByMonth(String month,String period,Months monthValue,String categoryKey) async {
    try{
      // isLoading = true;
      dateModel = await logsRepo.getDelayDate(month: month, period: period, categoryKey: categoryKey);
      // selectedMonth = videoConsultationModel!.data!.months![0];
      for(int x =0; x< dateModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == dateModel!.data!.months![x].key.toString()){
          selectedMonth = dateModel!.data!.months![x];
        }
      }
      // checkSelectedMonth(monthValue);
      print(selectedMonth!.value);
      print(monthValue.value);
      print(">>>>>>>>>>");
      isLoading = false;
      emit(GetDelayDateByMonth(monthValue));
    }
    catch(e){
      print(e);
      isLoading = false;
      emit(DelayDateErrorState());

    }
  }

  getDelayDateByDay(String month,String period,Months monthValue,String categoryKey, String day) async {
    try{
      // isLoading = true;
      dateModel = await logsRepo.getDelayDate(month: month, period: period, categoryKey: categoryKey, day: day);
      // selectedMonth = videoConsultationModel!.data!.months![0];
      for(int x =0; x< dateModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == dateModel!.data!.months![x].key.toString()){
          selectedMonth = dateModel!.data!.months![x];
        }
      }
      // checkSelectedMonth(monthValue);
      print(selectedMonth!.value);
      print(monthValue.value);
      print(">>>>>>>>>>");
      isLoading = false;
      emit(GetDelayDateByDay());
    }
    catch(e){
      print(e);
      isLoading = false;
      emit(DelayDateErrorState());

    }
  }

  checkDaySelectedIndex(int index,) {
    selectedIndex = index;
    emit(CheckDaySelectedIndex());
  }

  checkMonthSelectedIndex(Months? month,) {
    selectedMonth = month;
    emit(CheckDaySelectedIndex());
  }

  checkTimeSelectedIndex(int index,) {
    timeSelectedIndex = index;
    emit(CheckTimeSelectedIndex());
  }

void passSearchList( List<items> value) {
    searchData = [...value];
  }

  onSearchTextChange(String text) {
    List<items> temp = [];
    if (text.isEmpty) {
      searchData!.clear();
    } else {
      itemsList!.forEach((element) {
        if (element.username!.toLowerCase().contains(text.toLowerCase()))
          temp.add(element);
      });
      passSearchList(temp);
    }
    print(searchData!.length.toString());
    searchListLength = searchData!.length;
    emit(ItemsSearchState(searchListLength));
  }

}
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/teacher/logs/repo/LogsCategoriesModel.dart';
import 'package:istchrat/screens/teacher/logs/repo/LogsItemsModel1.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/delay_screen/DelayDateModel.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/repo/AcceptOrDeclineModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class LogsRepo{

  getLogsCategories() async{
        try{
          final dio = DioUtilNew.dio;
          final result = await DioUtilNew.get("logs/categories",
          );
          return LogsCategoriesModel.fromJson(result.data);
        }
        catch(e){
          print(e);
        }
      }

  getLogsItems(String categoryKey,String fromDate,String toDate,String statusKey,
      {required int paginatePage}) async{
        try{
          print(">>>>>>>>>>>>>>>>>>");
          final dio = DioUtilNew.dio;
          final result = await DioUtilNew.get("logs",
              queryParameters: {
                "category_key" : categoryKey,
                "start_date" : fromDate,
                "end_date" : toDate,
                "status_key" : statusKey,
                "page" : paginatePage,
                "paginate" : "5"
              }
          );
          print(result.data.toString() + "teeeettt");
          return LogsItemsModel1.fromJson(result.data);
        }
        catch(e){
          print(e.toString());
        }
      }

      Future<Either<String, AcceptOrDeclineModel>> acceptOrDecline(String categoryKey,String id,String status,
          String rejectReason,String delayedDate, String delayedTime,
          String answer) async{
        try{

          print(">>>>>>>>>>>>>>>>>>");
          final dio = DioUtilNew.dio;
          final result = await DioUtilNew.post("logs/acceptOrDecline/$id",
              data: {
                "status": status,
                "answer": answer,
                "reject_reason": rejectReason,
                "delayed_date": delayedDate,
                "delayed_time": delayedTime
              },
              queryParameters: {
                "category_key" : categoryKey,
              },
          );
          print(result.data.toString() + " data");
          print(result.statusCode);
          if(result.statusCode == 200){
            return Right(AcceptOrDeclineModel.fromJson(result.data));
          }else{
            return Left(AcceptOrDeclineModel.fromJson(result.data).data?.message ?? "unknown_error".tr);
          }
        }
        catch(e){
          print(e);
          return Left("unknown_error".tr);
        }
      }

      getDelayDate(
      {required String month, required String period, required String categoryKey, String? day})async{
        try{
          final dio = DioUtilNew.dio;
          final result = await DioUtilNew.get("logs/availableAppointments",
              queryParameters: {
                "category_key" : categoryKey,
                "month" : month,
                "period" : period,
                "day" : day,
              }
          );
          print(result.data);
          return DelayDateModel.fromJson(result.data);
        }
        catch(e){
          print(e);
        }
      }
    }


import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/book_details/cubit/books_details_state.dart';
import 'package:istchrat/screens/book_details/cubit/domain/books_repo_details.dart';
import 'package:istchrat/screens/book_details/models/books_detail_model.dart';
import 'package:istchrat/screens/course_details/domain/repo_details.dart';
import 'package:istchrat/screens/course_details/models/course_details_model.dart';
import 'package:istchrat/screens/in_app_purchase_screen/repository/iap_repository.dart';
import 'package:istchrat/usecases/addToFav.dart';
import 'package:istchrat/usecases/removeFromFav.dart';

import '../../../usecases/buy/buy_usecase.dart';

class BooksDetailsCubit extends Cubit<BooksDetailsState> {
  BooksDetailsCubit() : super(BooksDetailsInitial());
  static BooksDetailsCubit get(context) => BlocProvider.of(context);
  static final repository = BooksRepoDetails();
  BooksDetailModel? booksDetailsList = new BooksDetailModel();
  bool isLoading = true;
  getBooksDetails(String id) async {
    print(isLoading);
    try {
      isLoading = true;
      booksDetailsList = await repository.getBooksDetails(id);
      isLoading = false;
      // print("eeeeeeeeeee" + booksDetailsList!.row!.title.toString());
      emit(BooksDetailsSuccess());
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(BooksDetailsError(e.toString()));
    }
  }

  Future removeBookToFav(String id) async {
    if(!isLoading){
      final response = await RemoveFromFavUseCase.removeFromToFav(id: id, urlSegment: "books");
      if (response) {
        booksDetailsList!.row!.isFav = false;
        emit(RemovedFromFavSuccess());
      }
    }
  }

  Future addBookToFav(String id) async {
    final response = await AddToFavUseCase.addToFav(id: id, urlSegment: "books");
    if (response) {
      booksDetailsList!.row!.isFav = true;
      emit(AddedToFavSuccess());
    }
  }

  Future buyBook(String id) async {
    emit(BuyLoadingState());
    final response = await BuyUseCase.buy(
        type: "books", service: "buyBook", map: {"book_id": id});

    response.fold((error){
      emit(BuyErrorState(error));
    }, (data){
      emit(BuySuccessState(message: data.data?.message ?? "", id: data.data?.orderId?.toString() ?? ""));
    });
  }

  Future<void> addBookToLibrary(String id) async{
    emit(BuyLoadingState());
    final IAPRepository iapRepository = IAPRepository();
    final response = await iapRepository.buyItem(id: id, type: "book_sales");
    response.fold((error){
      emit(BuyErrorState(error));
    }, (data){
      emit(FreeBuySuccessState(message: "added_to_library".trParams({
        "product" : "Book".tr
      })));
    });
  }

}

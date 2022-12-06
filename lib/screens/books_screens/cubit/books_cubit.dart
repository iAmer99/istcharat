import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/books_screens/cubit/books_state.dart';
import 'package:istchrat/screens/books_screens/domain/books_repo.dart';
import 'package:istchrat/screens/books_screens/models/book_model.dart';
import 'package:istchrat/usecases/addToFav.dart';
import 'package:istchrat/usecases/removeFromFav.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksInitial());
  static BooksCubit get(context) => BlocProvider.of(context);
  static final repository = BooksRepo();
  BookModel? book_model = new BookModel();
  bool isLoading = true;
  getBooksList() async {
    print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    print(isLoading);
    try {
      isLoading = true;
      book_model = await repository.getBooks();
      isLoading = false;
      print("eeeeeeeeeee" + book_model!.data!.book_list!.length.toString());
      emit(BooksSuccess());
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(BooksError(e.toString()));
    }
  }
  getMyBooksList(bool isLogged) async {
    if(isLogged){
      print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
      print(isLoading);
      try {
        isLoading = true;
        book_model = await repository.getMyBooks();
        isLoading = false;
        //  print("eeeeeeeeeee" + book_model?.data?.book_list?.length.toString());
        emit(BooksSuccess());
      } on DioError catch (e) {
        // print(e);
        isLoading = false;
        emit(BooksError(e.toString()));
      }
    }
  }
  Future addMyBooksTofav(String id) async {
    final response =
        await AddToFavUseCase.addToFav(id: id, urlSegment: "books");
    if (response) {
      book_model!.data!.book_list!
          .firstWhere((element) => element.id.toString() == id)
          .isFavorite = true;
      emit(AddMyBookToFavSuccess());
    }
  }

  Future removeMybooksFromFav(String id) async {
    final response =
        await RemoveFromFavUseCase.removeFromToFav(id: id, urlSegment: "books");
    if (response) {
      book_model!.data!.book_list!
          .firstWhere((element) => element.id.toString() == id)
          .isFavorite = false;
      emit(RemovMyBookFromFavSuccess());
    }
  }
}

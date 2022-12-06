import 'package:istchrat/screens/books_screens/models/book_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class BooksRepo{
  Future<BookModel?> getBooks() async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("books?paginate=1000");
      return BookModel.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return BookModel();
    }
  }
  Future<BookModel?> getMyBooks() async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("books/mylibrary?paginate=1000");
      print(result.data.toString() + "test");
      return BookModel.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return BookModel();
    }
  }
}
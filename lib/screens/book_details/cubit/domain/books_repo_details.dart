import 'package:istchrat/screens/book_details/models/books_detail_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class BooksRepoDetails {
  Future<BooksDetailModel?> getBooksDetails(String id) async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("books/$id");
      return BooksDetailModel.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return BooksDetailModel();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/book_details/cubit/books_details_cubit.dart';
import 'package:istchrat/screens/book_details/cubit/books_details_state.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import '../../shared_components/helper_functions.dart';
import '../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../course_confirmation/payment_confirmation_screen.dart';
import '../main/cubit/main_cubit.dart';
import 'book_item_header.dart';
import 'models/books_detail_model.dart';

class BookDetails extends StatefulWidget {
  final String? id;
  final MainCubit? mainCubit;

  const BookDetails({Key? key, @required this.id, this.mainCubit}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  SnackBar? snackBar;
  late BooksDetailsCubit book_details_Cubit;
  book_details? book_data = new book_details();
  bool isLoading = true;
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void customSnackBar(String content, Color color, Duration duration,
      SnackBarAction snackBarAction) {
    snackBar = SnackBar(
      content: Text(content),
      backgroundColor: color,
      duration: duration,
      action: snackBarAction,
    );
    // Timer(Duration(seconds: 1), () {
    //   // _loginController.reset();
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar!);
    // });
    // scaffoldKey.currentState?.showSnackBar(snackBar!);
    Get.showSnackbar(GetSnackBar(
      title: "",
      message: content,
      backgroundColor: color,
      duration: duration,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BooksDetailsCubit()..getBooksDetails(widget.id!),
      child: BlocConsumer<BooksDetailsCubit, BooksDetailsState>(
        builder: (context, state) {
          book_details_Cubit = BooksDetailsCubit.get(context);
          isLoading = book_details_Cubit.isLoading;
          if (isLoading == false) {
            book_data = book_details_Cubit.booksDetailsList!.row!;
          }
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar.appBar(context,
                  text: "book_details".tr,
                  actions: [
                    isLoading
                        ? SizedBox()
                        : book_details_Cubit
                                        .booksDetailsList!.row!.isFavourite !=
                                    null &&
                                book_details_Cubit
                                    .booksDetailsList!.row!.isFavourite!
                            ? IconButton(
                                onPressed: () {
                                  book_details_Cubit
                                      .removeBookToFav(widget.id.toString());
                                  if(widget.mainCubit != null){
                                    widget.mainCubit!.getHomeData();
                                  }
                                },
                                icon: SvgPicture.asset(
                                    'assets/icons/star_colored.svg',
                                    color: yelloCollor),
                              )
                            : IconButton(
                                onPressed: () {
                                  book_details_Cubit
                                      .addBookToFav(widget.id.toString());
                                  if(widget.mainCubit != null){
                                    widget.mainCubit!.getHomeData();
                                  }
                                },
                                icon: SvgPicture.asset(
                                  'assets/icons/starbroken.svg',
                                  width: 20.w,
                                )),
                  ]),
              body: ModalProgressHUD(
                inAsyncCall: state is BuyLoadingState,
                child: SingleChildScrollView(
                  child: isLoading == true
                      ? Center(child: CircularProgressIndicator())
                      : BookDetailsHeader(
                          book_data: book_data,
                          cubit: book_details_Cubit,
                        ),
                ),
              ));
        },
        listener: (context, state) {
          if (state is BooksDetailsError) {
            failedDialog(context: context, message: state.error);
          } else if (state is BuyErrorState) {
            failedDialog(context: context, message: state.error);
          } else if (state is BuySuccessState) {
            Get.to(() => PaymentConfirmation(
                  title: "buy_the_book".tr,
                  id: state.id,
                  itemId: widget.id ?? "",
                  type: "books",
                ));
          } else if( state is FreeBuySuccessState){
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
                onTap: (){
                  Get.offAll(BottomNavBarScreen(openMyLibrary: true, index: getCategoryIndex("books"),),);
                },
              ),
            );
          }
        },
      ),
    );
  }
}

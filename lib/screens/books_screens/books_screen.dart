import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/screens/book_details/book_details.dart';
import 'package:istchrat/screens/books_screens/cubit/books_cubit.dart';
import 'package:istchrat/screens/books_screens/cubit/books_state.dart';
import 'package:istchrat/shared_components/colors.dart';

import '../../custom_widgets/custom_dialogs/nodata.dart';
import '../../shared_components/widgets/custom_app_bar.dart';
import 'models/book_model.dart';

class BooksScreen extends StatefulWidget {
  final String? title;

  const BooksScreen({Key? key, @required this.title}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  SnackBar? snackBar;
  late BooksCubit booksCubit;
  BookModel? data = new BookModel();
  bool isLoading = true;
  List<books>? booksList;
  bool showSearch = false;
  String keyword = "";

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
    scaffoldKey.currentState!.showSnackBar(snackBar!);
  }

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BooksCubit()..getBooksList(),
        child: Container(
          color: Colors.white,
          child: Scaffold(
              appBar: CustomAppBar.appBar(
                context,
                text: widget.title ?? "",
                search: showSearch,
                onSearch: (value) {
                  setState(() {
                    keyword = value;
                  });
                },
                actions: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 10.w),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          showSearch = !showSearch;
                        });
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/search.svg",
                        height: 30.h,
                        width: 30.w,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              body: BlocConsumer<BooksCubit, BooksState>(
                builder: (context, state) {
                  booksCubit = BooksCubit.get(context);
                  data = booksCubit.book_model;
                  isLoading = booksCubit.isLoading;
                  if (isLoading == false) {
                    if (keyword.isEmpty) {
                      booksList = data!.data!.book_list!;
                    } else {
                      booksList = data!.data!.book_list!
                          .where((element) => element.title!
                              .toLowerCase()
                              .contains(keyword.toLowerCase()))
                          .toList();
                    }
                  }
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isLoading == true
                                ? Center(child: CircularProgressIndicator())
                                : (booksList!.isEmpty
                                    ? Center(
                                        child: NoData(
                                          img: "assets/icons/books.svg",
                                        ),
                                      )
                                    : GridView.builder(
                                        itemCount: booksList!.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: .7),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(BookDetails(
                                                  id: booksList![index]
                                                      .id
                                                      .toString(),
                                                ));
                                              },
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: lightGrey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Image.network(
                                                      "${booksList![index].image}",
                                                      height: 100,
                                                      width: 110,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "${booksList![index].title}"),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          if (booksList![index]
                                                                  .publishedAt !=
                                                              null)
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    "assets/icons/calendar.svg"),
                                                                SizedBox(width: 3.w,),
                                                                Flexible(
                                                                  child: Text(
                                                                    "${booksList![index].publishedAt}",
                                                                    style: TextStyle(
                                                                        fontSize: 13
                                                                            .sp,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                              "${booksList![index].price} ${"USD".tr}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color:
                                                                      yelloCollor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      color: yelloCollor,
                                                      height: 30.h,
                                                      child: Center(
                                                          child: Text(
                                                        booksList![index]
                                                                    .isPurchased ==
                                                                true
                                                            ? "read_the_book".tr
                                                            : "buy_now".tr,
                                                        style: TextStyle(
                                                            fontSize: 13.sp),
                                                      )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is BooksError) {
                    customSnackBar(
                        "network_error".tr,
                        Colors.red,
                        Duration(days: 1),
                        SnackBarAction(
                            label: "",
                            textColor: Colors.white,
                            onPressed: () {
                              scaffoldKey.currentState!.hideCurrentSnackBar();
                              //ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            }));
                  }
                },
              )),
        ));
  }
}

// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/book_details/book_details.dart';
import 'package:istchrat/screens/main/cubit/main_cubit.dart';
import 'package:istchrat/screens/main/models/home_model.dart';
import 'package:istchrat/shared_components/colors.dart';

class BooksItem extends StatelessWidget {
  final BooksAuthors? books_list;
  final Function(String) addToFav;
  final Function(String) removeFromFav;
  final MainCubit? mainCubit;

  const BooksItem(
      {Key? key,
      @required this.books_list,
      required this.addToFav,
      required this.removeFromFav, this.mainCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(BookDetails(
          id: books_list!.id.toString(),
          mainCubit: mainCubit,
        ));
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 5.w, end: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 5,
              child: Container(
                width: 130.w,
                padding: EdgeInsetsDirectional.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: lightGrey),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                // color: Colors.white,
                //height: 180.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: GestureDetector(
                        onTap: () {
                          if (!books_list!.isFavorite!) {
                            addToFav(books_list!.id.toString());
                          } else {
                            removeFromFav(books_list!.id.toString());
                          }
                        },
                        child: books_list!.isFavorite!
                            ? SvgPicture.asset('assets/icons/star_colored.svg',
                                color: yelloCollor)
                            : SvgPicture.asset("assets/icons/starbroken.svg"),
                      ),
                    ),
                    Container(
                      height: 110.h,
                      child: Image.network(
                        "${books_list!.image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Flexible(
                      child: Text(
                        "${books_list!.title}",
                        style: TextStyle(
                          fontSize: 11.w,
                          fontWeight: FontWeight.normal,
                          color: darkGrey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                   if(books_list?.publishedAt != null) Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture
                            .asset(
                            "assets/icons/calendar.svg"),
                        SizedBox(
                          width:
                          3.w,
                        ),
                        Flexible(
                          child:
                          Text(
                            "${books_list?.publishedAt}",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Flexible(
                      child: Text(
                        "${books_list!.price}" + " " + "${books_list!.currency}",
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold,
                          color: yelloCollor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: 130.w,
                padding: EdgeInsetsDirectional.all(6),
                margin: EdgeInsetsDirectional.only(bottom: 10.h),
                decoration: BoxDecoration(
                  color: yelloCollor,
                  border: Border.all(width: 1.0, color: lightGrey),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                ),
                child: Center(
                    child: Text(
                 books_list!.isPurchased! ? "read_the_book".tr : "buy_now".tr,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: darkGrey,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

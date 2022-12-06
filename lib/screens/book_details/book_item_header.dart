import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:istchrat/screens/book_details/models/books_detail_model.dart';
import 'package:istchrat/screens/confirm_payment/video_confirm_appointment_screen.dart';
import 'package:istchrat/screens/pdf_screen/pdf_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';

import '../../custom_widgets/custom_dialogs/success_dialog/success_dialog.dart';
import '../../main.dart';
import '../../shared_components/constants/constants.dart';
import '../login/login_screen.dart';
import 'cubit/books_details_cubit.dart';

class BookDetailsHeader extends StatefulWidget {
  final book_details? book_data;
  final BooksDetailsCubit cubit;

  const BookDetailsHeader(
      {Key? key, @required this.book_data, required this.cubit})
      : super(key: key);

  @override
  State<BookDetailsHeader> createState() => _BookDetailsHeaderState();
}

class _BookDetailsHeaderState extends State<BookDetailsHeader> {
  var document;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(top: 40.h, start: 10.w, end: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.h),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                child: Row(
                  children: [
                    Container(
                      height: 120.h,
                      width: 76.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.h),
                          child: Image.network(
                            "${widget.book_data?.image ?? ""}",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: lightGrey,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 10.w, end: 10.w),
                            child: Text(
                              "${widget.book_data!.title}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.w),
                            ),
                          ),
                          SizedBox(
                            height: 9.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                color: lightGrey,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.book_data!.lecturer_name ?? "",
                                style: TextStyle(color: grey, fontSize: 15.w),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/archive_broken.svg',
                          height: 16.h,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "book_details_message".tr,
                            style: TextStyle(color: grey, fontSize: 15.w),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                margin: EdgeInsetsDirectional.only(
                    start: 20.w, end: 20.w, bottom: 10.h),
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: greyShap,
                  borderRadius: BorderRadius.circular(5.h),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "about_the_book".tr,
                style: TextStyle(
                    color: darkBlue,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                  "${parse(parse(widget.book_data!.body!).body!.text).documentElement!.text}"),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    "price".tr,
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ": ${widget.book_data!.price} ${widget.book_data!.currency}",
                    style: TextStyle(
                        color: darkGrey,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "buy_it".tr,
                            style: TextStyle(
                                color: yelloCollor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${widget.book_data!.sold}",
                            style: TextStyle(
                                color: darkGrey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "classification".tr,
                            style: TextStyle(
                                color: yelloCollor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${widget.book_data!.category_name}",
                            style: TextStyle(
                                color: darkGrey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "page_number".tr,
                            style: TextStyle(
                                color: yelloCollor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            widget.book_data!.pages?.toString() ?? 0.toString(),
                            style: TextStyle(
                                color: darkGrey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "date_of_publication".tr,
                            style: TextStyle(
                                color: yelloCollor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${widget.book_data!.publishedAt.toString()}",
                            style: TextStyle(
                                color: darkGrey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              RoundedYellowButton(
                  text: widget.book_data!.is_purchased == false
                      ? widget.book_data!.price == "0" ||
                      widget.book_data!.price == "0.0" ||
                      widget.book_data!.price == "0.00" ? "add_to_library".tr : "buy_the_book".tr
                      : "read_the_book".tr,
                  onTap: () {
                    if (widget.book_data!.is_purchased == true) {
                      if (widget.book_data!.attachments!.isNotEmpty &&
                          widget.book_data!.attachments![0].url != null &&
                          widget.book_data!.attachments![0].url != "") {
                        WidgetsBinding.instance!
                            .addPostFrameCallback((_) async {
                          Get.to(PdfScreen(
                            pdfUrl: widget.book_data!.attachments![0].url,
                          ));
                        });
                      } else {
                        Get.showSnackbar(const GetSnackBar(
                          title: "",
                          message: "Data isn't found",
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 5),
                        ));
                      }
                    } else {
                      final isLogged =
                          box.read(Constants.isLogged.toString()) ?? false;
                      if (isLogged) {
                        if (widget.book_data!.price == "0" ||
                            widget.book_data!.price == "0.0" ||
                            widget.book_data!.price == "0.00") {
                          widget.cubit.addBookToLibrary(widget.book_data!.id.toString());
                        } else {
                          widget.cubit.buyBook(widget.book_data!.id.toString());
                        }
                      } else {
                        successDialog(
                          context: context,
                          buttonTitle: "login".tr,
                          message: "you_should_login_first".tr,
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => LoginScreen(
                                  comeFromHome: true,
                                ));
                          },
                        );
                      }
                    }

                    /*     Get.to(
                        () => VideoConfirmAppointmentScreen(title: 'buy_the_book'.tr));*/
                  }),
              SizedBox(
                height: 30.w,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

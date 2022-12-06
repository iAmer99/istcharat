import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/usecases/add_notes_usecase.dart';

import '../../../shared_components/widgets/rounded_yellow_button.dart';
import '../teacher_waiting/details_screen/details_screen.dart';

class LogItem extends StatelessWidget {
  LogItem({
    Key? key,
    this.mobile,
    this.price,
    this.name,
    this.status,
    this.consultationType,
    this.date,
    this.notes,
    this.id,
    this.question,
    this.answer,
    this.categoryKey,
    this.navigate = true,
    this.showButton = true, required this.onStartLoading, required this.onEndLoading,this.onSuccess
  }) : super(key: key);
  String? consultationType,
      status,
      name,
      price,
      date,
      mobile,
      notes,
      id,
  question, answer,
      categoryKey;
  final bool navigate;
  final bool showButton;
  final Function onStartLoading;
  final Function onEndLoading;
  final Function(String)? onSuccess;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (navigate)
          Get.to(() => DetailsScreen(
                name: name,
                consultationType: consultationType,
                price: price,
                date: date,
                mobile: mobile,
                status: status,
                categoryKey: categoryKey,
                id: id,
                notes: notes,
            question: question,
            answer: answer,
              ));
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
            start: 20.w, end: 20.w, top: 10.h, bottom: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0, color: lightGrey),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       if(consultationType != null) Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/document.svg",
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "$consultationType",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      if(status != null && status!.isNotEmpty)  Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/status.svg",
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "$status",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  if(name != null)  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/user.svg",
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "$name",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                       if(price != null) Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/dollar.svg",
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "$price",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                   if(date != null && date!.isNotEmpty) Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/clock.svg",
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "$date",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      if(mobile != null)  Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/mobil.svg",
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "$mobile",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
              if (showButton)
                IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "",
                        content: Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Notes".tr,
                                        style: TextStyle(
                                            fontSize: 15.sp, color: mainColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15),
                                  child: TextFormField(
                                    controller: _controller,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "add_notes_validation".tr;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: lightGrey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide:
                                              BorderSide(color: lightGrey)),
                                      hintText: "add_notes".tr,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide(color: lightGrey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide(color: lightGrey),
                                      ),
                                    ),
                                    maxLines: 8,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: RoundedYellowButton(
                                      text: "add_notes".tr,
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          Get.back();
                                         onStartLoading();
                                          final response = await AddNotesUseCase
                                              .addNotesUseCase(
                                                  note: _controller.text,
                                                  id: id ?? "",
                                                  key: categoryKey ?? "");
                                          if(response['status_code'] == 200){
                                           onEndLoading();
                                            Get.snackbar("done".tr, response['message'], backgroundColor: mainColor);
                                            if(onSuccess != null) onSuccess!(categoryKey ?? "");
                                            _controller.text = "";
                                          }else{
                                            onEndLoading();
                                            Get.snackbar("error".tr, response['message'], backgroundColor: redColor);
                                            _controller.text = "";
                                          }
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit)),
            ],
          ),
        ),
      ),
    );
  }
}

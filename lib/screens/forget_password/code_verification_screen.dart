import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_button.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/screens/forget_password/create_new_password.dart';
import 'package:istchrat/screens/forget_password/cubit/forget_password_cubit.dart';
import 'package:istchrat/screens/forget_password/cubit/forget_password_states.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CodeVerificationScreen extends StatelessWidget {
  CodeVerificationScreen({Key? key, required this.email}) : super(key: key);

  final String email;
  TextEditingController code1Controller = TextEditingController();
  TextEditingController code2Controller = TextEditingController();
  TextEditingController code3Controller = TextEditingController();
  TextEditingController code4Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String code = '';
  ForgetPasswordCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            code = code1Controller.text +
                code2Controller.text +
                code3Controller.text +
                code4Controller.text;
            Get.to(CreateNewPassword(
              email: email,
            ));
          }else if(state is ResentCodeSuccessfully){
            Get.snackbar("done".tr, state.msg, backgroundColor: mainColor, colorText: Colors.white,);
          }else if(state is ResentCodeError){
            Get.snackbar("error".tr, state.errorMSG, backgroundColor: Colors.red,);
          }else if(state is ForgetPasswordFailed){
            failedDialog(context: context, message: state.errorMsg);
          }
        },
        builder: (context, state) {
          cubit = ForgetPasswordCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar.appBar(context, text: "verification_code".tr),
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25, right: 25, bottom: 15),
                        child: Row(
                          children: [
                            Text(
                              "verification_code".tr,
                              style:
                                  TextStyle(fontSize: 22.sp, color: darkGrey),
                            ),
                            SizedBox(
                              width: 20.sp,
                            ),
                            SvgPicture.asset("assets/icons/mobile2.svg")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "verification_code_sent".tr,
                                style: TextStyle(fontSize: 15.sp, color: grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 40),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLength: 1,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return " ";
                                  }
                                },
                                controller: code1Controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                maxLength: 1,
                                controller: code2Controller,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return " ";
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                maxLength: 1,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return " ";
                                  }
                                },
                                controller: code3Controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                maxLength: 1,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return " ";
                                  }
                                },
                                controller: code4Controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "did_not_get_code".tr,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          InkWell(
                            onTap: (){
                              cubit!.resendCode(email);
                            },
                            child: Text(
                              "resend_code".tr,
                              style:
                                  TextStyle(fontSize: 14.sp, color: mainColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            code = code1Controller.text +
                                code2Controller.text +
                                code3Controller.text +
                                code4Controller.text;
                            print(code);
                            print(email);
                            cubit!.verify(email, code);
                          }
                        },
                        title: "verify".tr,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/custom_widgets/custom_button.dart';
import 'package:istchrat/custom_widgets/custom_text_field.dart';
import 'package:istchrat/screens/forget_password/cubit/forget_password_cubit.dart';
import 'package:istchrat/screens/forget_password/cubit/forget_password_states.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';

class CreateNewPassword extends StatelessWidget {

  CreateNewPassword({required this.email,});
  final String email;
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _codeNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ForgetPasswordCubit? cubit;
  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>");
    return BlocProvider(create: (context)=>ForgetPasswordCubit(),
    child: BlocConsumer<ForgetPasswordCubit,ForgetPasswordState>(
        listener: (context,state){
          if(state is ForgetPasswordSuccess){
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
                onTap: (){
                  Get.offAll(()=> LoginScreen(comeFromHome: false));
                },
              ),
            );
          }
          else if(state is ResentCodeSuccessfully){
          Get.snackbar("done".tr, state.msg, backgroundColor: mainColor, colorText: Colors.white,);
          }else if(state is ResentCodeError){
          Get.snackbar("error".tr, state.errorMSG, backgroundColor: Colors.red,);
          }else if(state is ForgetPasswordFailed){
            failedDialog(context: context, message: state.errorMsg);
          }
        },
      builder: (context,state){
          cubit = ForgetPasswordCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar.appBar(context, text: "new_password".tr),
        body: ModalProgressHUD(
          inAsyncCall:  state is LoadingState,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 50.h,),
                  Padding(
                    padding:  EdgeInsets.only(left: 25,right: 25,bottom: 15),
                    child: Row(
                      children: [
                        Text("create_new_password".tr,
                          style: TextStyle(
                              fontSize: 22.sp,color: darkGrey),),
                        SizedBox(width: 20.sp,),
                        SvgPicture.asset("assets/icons/locker.svg")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("enter_new_password_message".tr,style: TextStyle(
                              fontSize: 15.sp,color: grey
                          ),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h,),
                  CustomTextField(
                    controller: codeController,
                    iconImage: "assets/icons/mobile2.svg",
                    hintText: "verification_code".tr,
                    keyboardType: TextInputType.number,
                    myValidator: (String? value) {
                      if(value!.isEmpty){
                        return "please_enter_verification_code".tr;
                      }else if(value.length != 4){
                        return "verification_code_length".tr;
                      } else{
                        return null;
                      }
                    },
                    myFocusNode: _codeNode,
                    nextFocusNode: _passwordNode,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    child: CustomTextField(
                      controller: passwordController,
                      iconImage: "assets/icons/key_colored.svg",
                      hintText: "password".tr,
                      keyboardType: TextInputType.visiblePassword,
                      myValidator: (String? value) {
                        if(value!.isEmpty){
                          return "password_validation2".tr;
                        }else if(value.length < 7){
                          return "password_validation".tr;
                        }
                      },
                      myFocusNode: _passwordNode,
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
                    title: "assign_new_password".tr,
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        print("<<<<<<<<<<<<");
                        cubit!.resetNewPassword(email, codeController.text, passwordController.text);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }, ),);
  }
}
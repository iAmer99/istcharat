import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_button.dart';
import 'package:istchrat/custom_widgets/custom_text_field.dart';
import 'package:istchrat/screens/forget_password/code_verification_screen.dart';
import 'package:istchrat/screens/forget_password/cubit/forget_password_cubit.dart';
import 'package:istchrat/screens/forget_password/cubit/forget_password_states.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'create_new_password.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final FocusNode _emailNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ForgetPasswordCubit? cubit;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>ForgetPasswordCubit(),
    child: BlocConsumer<ForgetPasswordCubit,ForgetPasswordState>(
        listener: (context,state){
          if(state is ForgetPasswordSuccess){
            Get.to(CreateNewPassword(email: emailController.text,));
          }
        },
      builder: (context,state){
          cubit = ForgetPasswordCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar.appBar(context, text: "forget_password".tr),
        body: ModalProgressHUD(inAsyncCall: state is LoadingState,
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
                          Text("assign_new_password".tr,
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
                            child: Text("enter_your_email_message".tr,style: TextStyle(
                                fontSize: 15.sp,color: grey
                            ),),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35.0),
                      child: CustomTextField(
                        iconImage: "assets/icons/email_message.svg",
                        hintText: "email".tr,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        myValidator: (String? value) {
                          if(value!.isEmpty){
                            return "email_validation".tr;
                          }else if(EmailValidator.validate(value) == false){
                            return "wrong_email".tr;
                          }
                        },
                        myFocusNode: _emailNode,
                      ),
                    ),
                    CustomButton(
                      title: "send_verification_code".tr,
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          cubit!.forgetPassword(emailController.text);
                        }
                      },
                    )
                  ],
                ),
              ),
            )),
      );
    }, ),);
  }
}

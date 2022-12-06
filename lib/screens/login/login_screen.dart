import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_button.dart';
import 'package:istchrat/custom_widgets/custom_text_field.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/screens/forget_password/forget_password_screen.dart';
import 'package:istchrat/screens/login/login_cubit/login_cubit.dart';
import 'package:istchrat/screens/login/login_cubit/login_states.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../main.dart';
import '../../shared_components/constants/constants.dart';
import '../sign_up/sign_up_screen.dart';
import '../teacher/teacher_bottom_nav_bar/teacher_bottom_nav_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({ required this.comeFromHome});
  bool comeFromHome ;
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  LoginCubit? loginCubit;


  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(create: (context)=>LoginCubit(),
    child: BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if(state is LoginSuccessState){
          if(comeFromHome == false){
             if(box.read(Constants.role.toString()) == "lecturer"){
                        Get.offAll(() => TeacherBottomNavBarScreen());
                      }else{
                        Get.offAll(() => BottomNavBarScreen());
                      }
          }else{
            Navigator.pop(context);
          }
        }
        else if(state is WrongUserState){
          failedDialog(
            context: context,
            message: state.errorMsg,
          );
        }
        else if(state is LoginErrorState ){
          failedDialog(
            context: context,
            message: "network_error".tr
          );
        }
      },
        builder: (context,state){
        loginCubit = LoginCubit.get(context);
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar.appBar(context, text: ""),
        body: ModalProgressHUD(
          inAsyncCall: state is LoadingState,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                 // SizedBox(height: MediaQuery.of(context).size.height * .15,),
                  Padding(
                    padding:  EdgeInsets.only(left: 25,right: 25,bottom: 15),
                    child: Row(
                      children: [
                        Text("welcome".tr,
                          style: TextStyle(
                              fontSize: 22.sp,color: darkGrey),),
                        SizedBox(width: 20.sp,),
                        SvgPicture.asset("assets/icons/emoji.svg")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("login_to_continue".tr,style: TextStyle(
                              fontSize: 15.sp,color: grey
                          ),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                      nextFocusNode: _passwordNode,
                    ),
                  ),
                  CustomTextField(
                    iconImage: "assets/icons/key_colored.svg",
                    hintText: "password".tr,
                    controller: passwordController,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    myValidator: (String? value) {
                      if(value!.isEmpty){
                        return "password_validation2".tr;
                      }else if(value.length < 7){
                        return "password_validation".tr;
                      }
                    },
                    myFocusNode: _passwordNode,
                    onComplete: (){},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>ForgetPasswordScreen());
                          },
                          child: Text("forget_password".tr,
                            style: TextStyle(fontSize: 14.sp,color: darkGrey),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,bottom: 25),
                    child: CustomButton(
                      title: "login".tr,
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          print("validate");
                          loginCubit!.login(emailController.text, passwordController.text);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>SignUpScreen());
                    },
                      child: Text("new_user".tr,style: TextStyle(fontSize: 16.sp,color: mainColor),)),


                ],
              ),
            ),
          ),
        ),
      );
    }),);
  }
}

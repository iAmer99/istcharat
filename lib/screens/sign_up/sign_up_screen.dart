import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_button.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/success_dialog.dart';
import 'package:istchrat/custom_widgets/custom_text_field.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/screens/sign_up/sign_up_cubit/sign_up_cubit.dart';
import 'package:istchrat/screens/sign_up/sign_up_cubit/sign_up_states.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../shared_components/widgets/rounded_yellow_button.dart';

class SignUpScreen extends StatelessWidget {
  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SignUpCubit? signUpCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(create: (context) =>SignUpCubit(),
    child: BlocConsumer<SignUpCubit,SignUpStates>(
        listener: (context,state){
          if(state is SignUpSuccessState){
            print("Sucessssssssss");
           successDialog(
             context: context,
             buttonTitle: "login".tr,
             message: state.message,
             onTap: (){
               Get.to(()=>LoginScreen(comeFromHome: false,));
             },
           );
          }else if(state is SignUpErrorState ){
            failedDialog(
                context: context,
                message: state.errorMsg,
            );
          }
        },
      builder: (context,state){
          signUpCubit = SignUpCubit.get(context);

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
                  Padding(
                    padding:  EdgeInsets.only(left: 25,right: 25,bottom: 15),
                    child: Row(
                      children: [
                        Text("create_new_account".tr,
                          style: TextStyle(
                              fontSize: 22.sp,color: darkGrey),),
                        SizedBox(width: 20.sp,),
                        SvgPicture.asset("assets/icons/emoji2.svg")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("create_new_account_text".tr,style: TextStyle(
                              fontSize: 15.sp,color: grey
                          ),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  CustomTextField(
                    iconImage: "assets/icons/edit_account.svg",
                    hintText: "name".tr,
                    keyboardType: TextInputType.text,
                    myValidator: (String? value) {
                      if(value!.isEmpty){
                        return "name_validation".tr;
                      }
                    },
                    myFocusNode: _nameNode,
                    nextFocusNode: _emailNode,
                    controller: nameController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CustomTextField(
                      iconImage: "assets/icons/email_message.svg",
                      hintText: "email".tr,
                      keyboardType: TextInputType.emailAddress,
                      myValidator: (String? value) {
                        if(value!.isEmpty){
                          return "email_validation".tr;
                        }else if(EmailValidator.validate(value) == false){
                          return "wrong_email".tr;
                        }
                      },
                      myFocusNode: _emailNode,
                      nextFocusNode: _phoneNode,
                      controller: emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: lightGrey)),
                      child: CountryPickerDropdown(
                        initialValue: 'KW',
                        isExpanded: true,
                        itemBuilder: _buildDropdownItem,
                        priorityList:[
                          CountryPickerUtils.getCountryByIsoCode('GB'),
                          CountryPickerUtils.getCountryByIsoCode('CN'),
                        ],
                        sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                        onValuePicked: (Country country) {
                          signUpCubit!.countryCode = "+${country.phoneCode}";
                          print("+${country.phoneCode}");
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    iconImage: "assets/icons/mobile.svg",
                    hintText: "phone_number".tr,
                    keyboardType: TextInputType.phone,
                    maxNum: 13,
                    myValidator: (String? value) {
                      if(value!.length < 7 || value.length > 13){
                        return "phoneNumber_validation".tr;
                      }
                    },
                    myFocusNode: _phoneNode,
                    nextFocusNode: _passwordNode,
                    onComplete: (){},
                    controller: phoneController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CustomTextField(
                      iconImage: "assets/icons/key_colored.svg",
                      hintText: "password".tr,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      myValidator: (String? value) {
                        if(value!.isEmpty){
                          return "password_validation2".tr;
                        }else if(value.length < 8){
                          return "password_validation".tr;
                        }
                      },
                      myFocusNode: _passwordNode,
                      onComplete: (){

                      },
                      controller: passwordController,
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 30.h),
                    child: CustomButton(
                      title: "sign_up".tr,
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          print("sssss");
                          signUpCubit!.signUp(nameController.text, emailController.text, passwordController.text,phoneController.text);
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("by_completing".tr,style: TextStyle(fontSize: 14.sp),),
                      SizedBox(width: 2,),
                      Text("terms_of_use".tr,style: TextStyle(fontSize: 14.sp,color: yelloCollor),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("and".tr,style: TextStyle(fontSize: 14.sp),),
                      SizedBox(width: 2,),
                      Text("privacy_policy".tr,style: TextStyle(fontSize: 14.sp,color: yelloCollor),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>LoginScreen(comeFromHome: false,));
                    },
                      child: Text("have_account".tr,style: TextStyle(fontSize: 16.sp,color: mainColor),)),
                ],
              ),
            ),
          ),
        ),
      );
    }, ),);


  }
  // signUpSuccessDialog(BuildContext context,String message){
  //   showDialog(context: context, builder: (BuildContext context){
  //     return Dialog(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         height: 300.sp,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Text(
  //                 "Istcharat",
  //                 style: TextStyle(fontSize: 21.sp,fontWeight: FontWeight.bold,color: darkGrey ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   message,
  //                   style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600 ),
  //                 ),
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   RoundedYellowButton(text: "Go To Login", onTap: (){
  //                     Navigator.pop(context);
  //                     Get.offAll(()=>LoginScreen());
  //                   }),
  //                   SizedBox(height: 20.w,),
  //                   GestureDetector(
  //                     onTap: (){
  //                       Navigator.pop(context);
  //                     },
  //                       child: Text("Cancel")),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  Widget _buildDropdownItem(Country country) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 10.w,),
      FittedBox(child: Text("+${country.phoneCode}")),
    ],
  );

}

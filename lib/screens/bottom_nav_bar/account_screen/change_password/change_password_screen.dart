import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/custom_widgets/custom_button.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import 'package:istchrat/custom_widgets/custom_text_field.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/change_password/change_password_cubit/change_password_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/change_password/change_password_cubit/change_password_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/change_password/repo/ChangePasswordModel.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final FocusNode _oldPassword = FocusNode();
  final FocusNode _newPassword = FocusNode();
  final FocusNode _confirmationPassword = FocusNode();

  ChangePasswordCubit? changePasswordCubit;
  ChangePasswordModel? changePasswordModel;
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
                onTap: () {
                  Get.back();
                },
              ),
            );
          } else if (state is ChangePasswordFailed) {
            failedDialog(context: context, message: state.msg);
          }
        },
        builder: (context, state) {
          changePasswordCubit = ChangePasswordCubit.get(context);
          changePasswordModel = changePasswordCubit!.changePasswordModel;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar.appBar(context, text: "change_password".tr),
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        maxRadius: 100.w,
                        minRadius: 100.w,
                        backgroundImage: _getImage(),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CustomTextField(
                      iconImage: "assets/icons/key.svg",
                      hintText: "enter_old_password".tr,
                      isPassword: true,
                      myFocusNode: _oldPassword,
                      nextFocusNode: _newPassword,
                      keyboardType: TextInputType.text,
                      controller: oldPasswordController,
                      myValidator: (String? value) {
                        if (value!.isEmpty) {
                          return "enter_old_password".tr;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: CustomTextField(
                        iconImage: "assets/icons/key.svg",
                        hintText: "enter_new_password".tr,
                        isPassword: true,
                        myFocusNode: _newPassword,
                        nextFocusNode: _confirmationPassword,
                        keyboardType: TextInputType.text,
                        controller: newPasswordController,
                        myValidator: (String? value) {
                          if (value!.isEmpty) {
                            return "enter_new_password".tr;
                          } else if (value.length < 8) {
                            return "password_validation".tr;
                          }
                        },
                      ),
                    ),
                    CustomTextField(
                      iconImage: "assets/icons/key.svg",
                      hintText: "enter_new_password_again".tr,
                      isPassword: true,
                      myFocusNode: _confirmationPassword,
                      controller: confirmationPasswordController,
                      onComplete: () {},
                      keyboardType: TextInputType.text,
                      myValidator: (String? value) {
                        if (value!.isEmpty) {
                          return "enter_new_password_again".tr;
                        } else if (value != newPasswordController.text) {
                          return "password_dont_match".tr;
                        }
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          changePasswordCubit!.changePassword(
                              oldPasswordController.text,
                              newPasswordController.text,
                              confirmationPasswordController.text);
                        }
                      },
                      title: "change_password".tr,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ImageProvider _getImage() {
    if (box.read(Constants.avatar.toString()) != null) {
      return NetworkImage(
        box.read(Constants.avatar.toString()),
      );
    } else {
      return AssetImage("assets/images/avatar1.png");
    }
  }
}

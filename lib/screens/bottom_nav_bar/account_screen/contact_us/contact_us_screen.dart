import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import 'package:istchrat/custom_widgets/custom_text_field.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/contact_us/contact_us_cubit/contact_us_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/contact_us/contact_us_cubit/contact_us_states.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../custom_widgets/custom_dialogs/success_dialog/success_dialog.dart';
import '../../../../main.dart';
import '../../../../shared_components/constants/constants.dart';
import '../../../login/login_screen.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final FocusNode _nameNode = FocusNode();

  final FocusNode _emailNode = FocusNode();

  final FocusNode _questionNode = FocusNode();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController questionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  ContactUsCubit? contactUsCubit;

  @override
  void initState() {
    final isLogged =
    box.read(Constants.isLogged.toString());
    if(isLogged != null && isLogged){
      nameController.text = box.read(Constants.userName.toString());
      emailController.text = box.read(Constants.email.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsCubit(),
      child: BlocConsumer<ContactUsCubit, ContactUsStates>(
        listener: (context, state) {
          if (state is ContactUsSuccess) {
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
                onTap: (){
                  Get.back();
                },
              ),
            );
          } else if (state is ContactUsError) {
            failedDialog(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          contactUsCubit = ContactUsCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar.appBar(context, text: "help".tr),
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        iconImage: "assets/icons/edit_account.svg",
                        hintText: "name".tr,
                        keyboardType: TextInputType.text,
                        ignorePointer: box.read(Constants.isLogged.toString()) && nameController.text.isNotEmpty,
                        myValidator: (String? value) {
                          if (value!.isEmpty) {
                            return "name_validation".tr;
                          }
                        },
                        myFocusNode: _nameNode,
                        nextFocusNode: _emailNode,
                        controller: nameController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: CustomTextField(
                          iconImage: "assets/icons/email_message.svg",
                          hintText: "email".tr,
                          ignorePointer: box.read(Constants.isLogged.toString()) && emailController.text.isNotEmpty,
                          keyboardType: TextInputType.emailAddress,
                          myValidator: (String? value) {
                            if (value!.isEmpty) {
                              return "email_validation".tr;
                            } else if (EmailValidator.validate(value) ==
                                false) {
                              return "wrong_email".tr;
                            }
                          },
                          myFocusNode: _emailNode,
                          nextFocusNode: _questionNode,
                          controller: emailController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 15),
                        child: TextFormField(
                          controller: questionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "question_validation".tr;
                            }
                          },
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: lightGrey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: lightGrey)),
                            hintText: "question_hint_text".tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: lightGrey),
                            ),
                          ),
                          maxLines: 8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 50),
                        child: RoundedYellowButton(
                            text: "send".tr,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                              /*  final isLogged =
                                    box.read(Constants.isLogged.toString());
                                if (isLogged == null || isLogged == false) {
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
                                } else { */
                                  contactUsCubit!.contactUs(
                                      nameController.text,
                                      emailController.text,
                                      questionController.text);

                              }
                            }),
                      ),
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

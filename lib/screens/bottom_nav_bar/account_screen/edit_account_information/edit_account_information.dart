import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:istchrat/custom_widgets/custom_button.dart';
import 'package:istchrat/custom_widgets/custom_text_field.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/edit_acc_info_cubit/edit_acc_info_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/edit_acc_info_cubit/edit_acc_info_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/repo/AccountInfoModel.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../main.dart';
import '../../../../shared_components/constants/constants.dart';

class EditAccountInformation extends StatefulWidget {
  EditAccountInformation({Key? key}) : super(key: key);

  @override
  State<EditAccountInformation> createState() => _EditAccountInformationState();
}

class _EditAccountInformationState extends State<EditAccountInformation> {
  final FocusNode _nameNode = FocusNode();

  final FocusNode _emailNode = FocusNode();

  final FocusNode _phoneNode = FocusNode();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  EditAccInfoCubit? editAccInfoCubit;

  AccountInfoModel? accInfoModel;
  final _formKey = GlobalKey<FormState>();

  bool isError = false;

  bool isLoading = false;

  File? _image;
  String imageBase64 = '';
  final _picker = ImagePicker();

  getImageBase64() async {
    Uint8List imagebytes = await _image!.readAsBytes(); //convert to bytes
    imageBase64 =
        "data:image/${_image!.path.substring(_image!.path.lastIndexOf(".") + 1)};base64," +
            base64Encode(imagebytes); //convert bytes to base64 string
  }

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        getImageBase64();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAccInfoCubit()..getAccountInformation(),
      child: BlocConsumer<EditAccInfoCubit, EditAccInfoStates>(
        listener: (context, state) {
          if (state is GetAccInfoSuccess) {
            nameController.text = state.accInfoModel.row!.name.toString();
            emailController.text = state.accInfoModel.row!.email.toString();
            phoneController.text = state.accInfoModel.row!.mobile.toString();
          } else if (state is GetAccInfoSuccessError) {
            Get.snackbar("error".tr, "network_error".tr,
                backgroundColor: Colors.redAccent, colorText: Colors.white);
          } else if (state is UpdateAccInfoSuccessfully) {
            Get.back();
            Get.snackbar(
              "done".tr,
              "changed_successfully".tr,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          editAccInfoCubit = EditAccInfoCubit.get(context);
          isLoading = editAccInfoCubit!.isLoading;
          accInfoModel = editAccInfoCubit!.accInfoModel;
          isError = editAccInfoCubit!.isError;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar.appBar(context, text: "edit_account_information".tr),
            body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : isError == true
                ? NetFailedWidget(onPress: () {
                    editAccInfoCubit!.emit(EditAccInfoInitialStates());
                    editAccInfoCubit!.getAccountInformation();
                  })
                : ModalProgressHUD(
                    inAsyncCall: state is LoadingState,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: _openImagePicker,
                              child: Container(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 25),
                              child: Text(
                                "Delete Photo",
                                style: TextStyle(
                                    fontSize: 14.sp, color: redColor),
                              ),
                            ),
                            CustomTextField(
                              iconImage: "assets/icons/edit_account.svg",
                              hintText: "name".tr,
                              keyboardType: TextInputType.text,
                              controller: nameController,
                              myValidator: (String? value) {
                                if (value!.isEmpty) {
                                  return "name_validation".tr;
                                }
                              },
                              myFocusNode: _nameNode,
                              nextFocusNode: _emailNode,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0),
                              child: CustomTextField(
                                iconImage: "assets/icons/email_message.svg",
                                hintText: "email".tr,
                                enabled: false,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                myValidator: (String? value) {},
                                myFocusNode: _emailNode,
                                nextFocusNode: _phoneNode,
                              ),
                            ),
                            CustomTextField(
                              iconImage: "assets/icons/mobile.svg",
                              hintText: "phone_number".tr,
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              myValidator: (String? value) {
                                if (value!.length < 7 ||
                                    value.length > 15) {
                                  return "phoneNumber_validation".tr;
                                }
                              },
                              myFocusNode: _phoneNode,
                              onComplete: () {},
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            CustomButton(
                              title: "edit".tr,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  editAccInfoCubit!.editAccountInformation(
                                      nameController.text,
                                      phoneController.text,
                                      imageBase64);
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 25),
                              child: GestureDetector(
                                onTap: () {
                                  Get.dialog(AlertDialog(
                                    title: Text(
                                      "delete_account".tr,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: redColor),
                                    ),
                                    content: Text(
                                      "delete_account_confirmation".tr,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black),
                                    ),
                                    actions: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          editAccInfoCubit?.deleteAccount();
                                        },
                                        child: Text(
                                          "delete".tr,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: redColor),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "cancel".tr,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ));
                                },
                                child: Text(
                                  "delete_account".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: redColor),
                                ),
                              ),
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

  ImageProvider _getImage() {
    if (box.read(Constants.avatar.toString()) != null) {
      return NetworkImage(
        box.read(Constants.avatar.toString()),
      );
    } else if (_image != null) {
      return FileImage(_image!);
    } else {
      return AssetImage("assets/images/avatar1.png");
    }
  }

  }

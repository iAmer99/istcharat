import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/success_dialog.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/confirm_payment/video_confirm_appointment_screen.dart';
import 'package:istchrat/screens/consultation_screen/widgets/consultant_details.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/screens/question_and_answer/confirm_question_answer/confirm_question_answer_screen.dart';
import 'package:istchrat/screens/question_and_answer/cubit/question_answer_cubit.dart';
import 'package:istchrat/screens/question_and_answer/cubit/question_answer_states.dart';
import 'package:istchrat/screens/question_and_answer/repo/QuestionAnswerModel1.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../confirm_payment/widgets/success_dialog_content.dart';

class QuestionAndAnswerScreen extends StatelessWidget {
     QuestionAndAnswerScreen({Key? key,required this.consultationType,required this.title}) : super(key: key);
     final String consultationType;
     final String title;
  final box = GetStorage();
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
     QuestionAnswerModel1? questionAnswerModel;
  QuestionAnswerCubit? questionAnswerCubit;
  bool isLoading = true;
  bool isError = false;

     @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> QuestionAnswerCubit()..getQuestionAnswerData(consultationType),
    child: BlocConsumer<QuestionAnswerCubit,QuestionAnswerStates>(
      listener: (context,state){
        if(state is BookAppointmentSuccessfully){
          Get.to(()=>  ConfirmQuestionAnswerScreen(
            title: title,
            bookID: state.bookID,
            consultationType: consultationType,
          ));
        }
        else if(state is BookAppointmentErrorState){
          failedDialog(
              context: context,
              message: "network_error".tr
          );
        }
        else if(state is BookAppointmentFailed){
          failedDialog(
              context: context,
              message: state.message
          );
        }
      },
      builder: (context,state){
        questionAnswerCubit = QuestionAnswerCubit.get(context);
        questionAnswerModel = questionAnswerCubit?.questionAnswerModel;
        isLoading = questionAnswerCubit?.isLoading ?? false;
        isError = questionAnswerCubit?.isError ?? false;

      return Scaffold(
        appBar: CustomAppBar.appBar(context, text: title),
        backgroundColor: Colors.white,
        body: isLoading == true ? Center(child: CircularProgressIndicator()) :
        isError == true ? NetFailedWidget(onPress: (){
          questionAnswerCubit!.emit(QuestionAnswerInitialStates());
          questionAnswerCubit!.getQuestionAnswerData(consultationType);
        }) :ModalProgressHUD(
          inAsyncCall: state is LoadingState,
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ConsultantDetails(videoConsultationModel: questionAnswerModel,),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text("what_your_question".tr,style: TextStyle(fontSize: 15.sp,color: mainColor,
                          fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
                      child: TextFormField(
                        controller: controller,
                        validator: (value){
                          if(value!.isEmpty){
                            return "question_validation".tr;
                          }
                        },
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: lightGrey
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: lightGrey
                              )
                          ),
                          hintText: "question_hint_text".tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: lightGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: lightGrey),
                          ),

                        ),maxLines: 8,
                        maxLength: 300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 50),
                      child: RoundedYellowButton(
                          text: "continue".tr,
                          onTap: () {
                            if(box.read("isUploading")){
                              Get.defaultDialog(
                                title: "",
                                content: SuccessDialogContent(
                                  message: "",
                                ),
                              );
                            }else{
                              final isLogged = box.read(Constants.isLogged.toString());
                              if(isLogged== null || isLogged == false){
                                successDialog(
                                  context: context,
                                  buttonTitle: "login".tr,
                                  message: "you_should_login_first".tr,
                                  onTap: (){
                                    Navigator.pop(context);
                                    Get.to(()=>LoginScreen(comeFromHome: true,));
                                  },
                                );
                              }else{
                                if(_formKey.currentState!.validate()){
                                  questionAnswerCubit?.getBookQuestionData(controller.text,consultationType);
                                }
                                // print(videoConsultationModel!.data!.periods![consultationCubit!.durationSelectedIndex].key.toString());
                              }
                            }

                          }),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }, ),);
  }
}

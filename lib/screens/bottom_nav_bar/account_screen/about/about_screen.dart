import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/about/about_cubit/about_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/about/about_cubit/about_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/about/repo/AboutModel.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';


class AboutScreen extends StatelessWidget {
   AboutScreen({Key? key,required this.type, required this.title}) : super(key: key);
   final String type;
   final String title;
   AboutCubit? aboutCubit;
   AboutModel? aboutModel;
   bool isLoading = true;
   bool isError = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AboutCubit()..getAboutData(type),
    child: BlocConsumer<AboutCubit,AboutStates>(
        listener: (context,state){},
      builder: (context,state){
          aboutCubit = AboutCubit.get(context);
          aboutModel= aboutCubit!.aboutModel;
          isError = aboutCubit!.isError;
          isLoading = aboutCubit!.isLoading;

          return Scaffold(
            appBar: CustomAppBar.appBar(context, text: title),
        backgroundColor: Colors.white,
        body: isLoading == true ? Center(child: CircularProgressIndicator()) :
        isError == true ? NetFailedWidget(onPress: (){
          aboutCubit!.emit(AboutInitialStates());
          aboutCubit!.getAboutData(type);
        }) :Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(aboutModel!.data!.body!.toString(),style: TextStyle(
                  fontSize: 20.sp
                ),),
              ),
            )
          ],
        ),
      );
    }, ),);
  }
}

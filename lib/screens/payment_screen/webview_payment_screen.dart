import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/shared_components/helper_functions.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';


class WebViewPaymentScreen extends StatelessWidget {
  const WebViewPaymentScreen({Key? key, required this.paymentURL, required this.type}) : super(key: key);
  final String paymentURL;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: WebViewPlus(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: paymentURL,
            onWebViewCreated: (controller) {
              // controller.loadString(_controller.htmlScript);
              controller.webViewController.clearCache();
            },
            onPageStarted: (String url) {
              print(url + " teeeeetttts");
              if (url.contains('api/payment/error')) {
                failedDialog(
                  context: context,
                  message: "paid_failed".tr,
                  onCancel: (){
                    Get.offAll(()=> BottomNavBarScreen());
                  },
                );
              } else if (url.contains('api/payment/success')) {
                Get.defaultDialog(
                  title: "",
                  content: CustomSuccessDialog(
                    message: "paid_successfully".tr,
                    onTap: (){
                      Get.offAll(BottomNavBarScreen(openMyLibrary: true, index: getCategoryIndex(type),),);
                    },
                  ),
                  barrierDismissible: false,
                );
              }
            },
          ),
          appBar: CustomAppBar.appBar(context, text: "payment".tr),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/wallet/controller/wallet_controller.dart';
import 'package:istchrat/screens/wallet/widgets/balance_card.dart';
import 'package:istchrat/screens/wallet/widgets/refund_carrd.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';

class WalletScreen extends GetView<WalletController> {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(context, text: "wallet".tr),
      body: controller.obx(
        (data) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                BalanceCard(
                  balance: data?.data?.balance ?? "",
                  currency: data?.data?.currency ?? "",
                ),
                SizedBox(
                  height: 50.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data?.data?.items?.length ?? 0,
                    itemBuilder: (context, index) => RefundCard(
                      item: data!.data!.items![index],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        onLoading: const Center(
          child: CircularProgressIndicator(
            color: mainColor,
          ),
        ),
        onError: (error) => Center(
          child: Text(
            error ?? "",
            style: TextStyle(color: mainColor, fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}

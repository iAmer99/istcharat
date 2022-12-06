import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/shared_components/colors.dart';

class CostDetails extends StatelessWidget {
  CostDetails(
      {Key? key,
      this.total,
      this.communicationMethod,
      this.consultationFees,
      this.tax,
      this.feesText,
        required this.discount,
      this.currency})
      : super(key: key);
  String? communicationMethod, consultationFees, tax, total, currency, feesText, discount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (communicationMethod != null && communicationMethod!.isNotEmpty)
          _buildDetailsRow(
              title: "communication_method".tr, data: "$communicationMethod"),
        SizedBox(
          height: 5.h,
        ),
        _buildDetailsRow(
            title: feesText ?? "consultation_fees".tr, data: "$consultationFees $currency"),
        SizedBox(
          height: 5.h,
        ),
        _buildDetailsRow(title: "tax".tr, data: "$tax $currency"),
        SizedBox(
          height: 5.h,
        ),
       if(discount != null && discount!.isNotEmpty) _buildDetailsRow(title: "discount".tr, data: "$discount $currency"),
        if(discount != null && discount!.isNotEmpty) SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "total".tr,
              style: TextStyle(
                  color: darkGrey, fontSize: 16.w, fontWeight: FontWeight.w500),
            ),
            Text(
              "$total $currency",
              style: TextStyle(
                  color: darkGrey, fontSize: 16.w, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }

  Row _buildDetailsRow({required String title, required String data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: darkGrey, fontSize: 16.w),
        ),
        Text(
          data,
          style: TextStyle(color: darkGrey, fontSize: 16.w),
        ),
      ],
    );
  }
}

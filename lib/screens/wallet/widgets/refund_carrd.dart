import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/screens/wallet/repository/model/WalletResponse.dart';
import '../../../shared_components/colors.dart';

class RefundCard extends StatelessWidget {
  const RefundCard({Key? key, required this.item}) : super(key: key);
  final Items item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(
          color: Colors.black54.withOpacity(0.5),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.categoryKey ?? "",
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                ),
                if (item.status != null)
                  Text(
                    item.status == "2"
                        ? item.rejectReason ?? ""
                        : "It's delayed to ${item.delayedDate} at ${item.delayedTime}",
                    style: TextStyle(color: Colors.black87, fontSize: 15.sp),
                  ),
              ],
            ),
          ),
          Flexible(
              flex: 1,
              child: Text(
                "${item.price} ${item.currency}",
                style: TextStyle(
                    color: yelloCollor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}

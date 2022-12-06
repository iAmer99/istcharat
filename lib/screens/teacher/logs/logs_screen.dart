import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/nodata.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/teacher/logs/cubit/logs_cubit.dart';
import 'package:istchrat/screens/teacher/logs/cubit/logs_states.dart';
import 'package:istchrat/screens/teacher/logs/log_item.dart';
import 'package:istchrat/screens/teacher/logs/repo/LogsCategoriesModel.dart';
import 'package:istchrat/screens/teacher/logs/repo/LogsItemsModel1.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/teacher_waiting_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/helper_functions.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  int selectedTap = 0;

  checkSelectedTap(int index) {
    setState(() {
      selectedTap = index;
    });
  }

  LogsCategoriesModel? logsCategoriesModel;
  LogsCubit? logsCubit;
  bool isLoading = true;
  bool logsItemsLoading = true;
  LogsItemsModel1? itemModel;
  TextEditingController controller = TextEditingController();
  int searchListLength = 0;
  List<items>? searchItemsListData = [];
  bool isError = false;
  String selectedStatus = 'pending';
  int categoryKeyIndex = 0;
  List<String> status = ["pending", "approved", "rejected", "delayed"];
  bool addNotesLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogsCubit()..getLogsCategories(),
      child: BlocConsumer<LogsCubit, LogsStates>(
        listener: (context, state) {
          if (state is ItemsSearchState) {
            searchListLength = state.length;
            switchList();
          }
        },
        builder: (context, state) {
          logsCubit = LogsCubit.get(context);
          logsCategoriesModel = logsCubit!.logsCategoriesModel;
          isLoading = logsCubit!.isLoading;
          logsItemsLoading = logsCubit!.logsItemsLoading;
          itemModel = logsCubit!.itemModel;
          searchItemsListData = logsCubit!.searchData;
          isError = logsCubit!.isError;

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xffFAFAFA),
                toolbarHeight: 66.h,
                leadingWidth: 82.w,
                leading: Visibility(
                  visible: false,
                  child: GestureDetector(
                    child: Container(
                      width: 40.w,
                      height: 30.h,
                      margin: EdgeInsetsDirectional.only(
                          start: 15.w, end: 10.w, top: 10.h, bottom: 10.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: lightGrey)),
                      // padding: EdgeInsets.all(5.h),
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.h,
                        color: darkGrey,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              title: "",
                              content: searchDialog(context),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            width: 30.w,
                            height: 30.h,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                                title: '', content: filterDialog());
                          },
                          child: SvgPicture.asset(
                            "assets/icons/filter.svg",
                            width: 30.w,
                            height: 30.h,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        )
                      ],
                    ),
                  )
                ],
                title: Text(
                  "logs".tr,
                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : isError == true
                      ? NetFailedWidget(onPress: () {
                          logsCubit!.emit(LogsInitialStates());
                          logsCubit!.getLogsCategories();
                        })
                      : ModalProgressHUD(
                          inAsyncCall: addNotesLoading,
                          child: Container(
                            margin: EdgeInsetsDirectional.only(top: 20.h),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.h, vertical: 15.h),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (var index = 0;
                                            index <
                                                logsCategoriesModel!
                                                    .data!.rows!.length;
                                            index++)
                                          _buildTypeTap(
                                              index: index,
                                              title: logsCategoriesModel!
                                                  .data!.rows![index].value
                                                  .toString(),
                                              icon: getIconPath(
                                                  logsCategoriesModel!
                                                      .data!.rows![index].key
                                                      .toString())),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: logsItemsLoading == true
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : itemModel!.data!.rows!.isEmpty
                                          ? Container(
                                              child: Center(
                                                child: NoData(
                                                    img: getIconPath(
                                                        logsCategoriesModel!
                                                            .data!
                                                            .rows![selectedTap]
                                                            .key
                                                            .toString())),
                                              ),
                                            )
                                          : switchList(),
                                ) /*  Expanded(child: tapsTrigger())*/
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

  searchDialog(
    BuildContext context,
  ) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Text(
                  "search_with_user_name".tr,
                  style: TextStyle(fontSize: 15.sp, color: mainColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: TextFormField(
              controller: controller,
              onChanged: (value) => onSearchTextChange(value),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: lightGrey)),
                hintText: "write_user_name".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: lightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: lightGrey),
                ),
              ),
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: RoundedYellowButton(
                text: "search".tr,
                onTap: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }

  Widget switchList() {
    if (searchListLength != 0 || controller.text.isNotEmpty) {
      return searchItemsList();
    } else {
      return itemsList();
    }
  }

  onSearchTextChange(String text) async {
    logsCubit!.onSearchTextChange(text);
  }

  itemsList() {
    return LazyLoadScrollView(
      onEndOfPage: () {
        if (logsCubit != null && !logsCubit!.lastPaginatePage) {
          logsCubit!.getMoreLogsItems(
              logsCategoriesModel!.data!.rows![selectedTap].key.toString(),
              fromDate.toString().substring(0, 10),
              toDate.toString().substring(0, 10),
              selectedStatus);
        }
      },
      child: ListView.builder(
          itemCount: itemModel!.data!.rows!.length,
          itemBuilder: (context, index) {
            return LogItem(
              name: itemModel!.data!.rows![index].username,
              consultationType: itemModel!.data!.rows![index].type,
              categoryKey:
                  logsCategoriesModel?.data?.rows?[categoryKeyIndex].key,
              price: itemModel!.data!.rows![index].price,
              id: itemModel!.data!.rows![index].id,
              notes: itemModel!.data!.rows![index].notes,
              date: itemModel!.data!.rows![index].delayed ?? false
                  ? "${itemModel!.data!.rows![index].delayedDate ?? ""} ${itemModel!.data!.rows![index].delayedTime ?? ""}"
                  : itemModel!.data!.rows![index].date,
              mobile: itemModel!.data!.rows![index].mobile,
              status: itemModel!.data!.rows![index].status,
              question: itemModel!.data!.rows![index].question,
              answer: itemModel!.data!.rows![index].answer,
              onStartLoading: () {
                setState(() {
                  addNotesLoading = true;
                });
              },
              onEndLoading: () {
                setState(() {
                  addNotesLoading = false;
                });
              },
              onSuccess: (String categoryKey) {
                logsCubit!.getLogsItems(
                    categoryKey,
                    fromDate.toString().substring(0, 10),
                    toDate.toString().substring(0, 10),
                    selectedStatus);
              },
            );
          }),
    );
  }

  searchItemsList() {
    return ListView.builder(
        itemCount: searchItemsListData!.length,
        itemBuilder: (context, index) {
          return LogItem(
            id: searchItemsListData![index].id,
            categoryKey: logsCategoriesModel?.data?.rows?[categoryKeyIndex].key,
            name: searchItemsListData![index].username,
            consultationType: searchItemsListData![index].type,
            price: searchItemsListData![index].price,
            date: searchItemsListData![index].delayed ?? false
                ? "${searchItemsListData![index].delayedDate ?? ""} ${searchItemsListData![index].delayedTime ?? ""}"
                : searchItemsListData![index].date,
            mobile: searchItemsListData![index].mobile,
            status: searchItemsListData![index].status,
            notes: searchItemsListData![index].notes,
            question: searchItemsListData![index].question,
            answer: searchItemsListData![index].answer,
            onStartLoading: () {
              setState(() {
                addNotesLoading = true;
              });
            },
            onEndLoading: () {
              setState(() {
                addNotesLoading = false;
              });
            },
            onSuccess: (String categoryKey) {
              logsCubit!.getLogsItems(
                  categoryKey,
                  fromDate.toString().substring(0, 10),
                  toDate.toString().substring(0, 10),
                  selectedStatus);
            },
          );
        });
  }

  filterDialog() {
    return StatefulBuilder(
      builder: (context, setState) {
        setState(() {
          print(fromDate);
        });
        return Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "by_period".tr,
                  style: TextStyle(fontSize: 15.sp, color: mainColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // setState(() {
                          //   _selectDate(context);
                          // });
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: fromDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101));
                          if (picked != null && picked != fromDate) {
                            setState(() {
                              fromDate = picked;
                              print(fromDate);
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Text(
                              "from".tr,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: lightGrey)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 20.h),
                                child: Text(
                                    fromDate.toString().substring(0, 10),
                                    style: TextStyle(fontSize: 15.sp)))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: toDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101));
                          if (picked != null && picked != toDate) {
                            setState(() {
                              toDate = picked;
                              print(toDate);
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Text(
                              "to".tr,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: lightGrey)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 20.h),
                                child: Text(toDate.toString().substring(0, 10),
                                    style: TextStyle(fontSize: 15.sp)))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "by_status".tr,
                  style: TextStyle(fontSize: 15.sp, color: mainColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: lightGrey),
                        borderRadius: BorderRadius.circular(30)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        //hint:'',
                        dropdownColor: Colors.white,
                        icon: Padding(
                          padding: EdgeInsetsDirectional.only(start: 30.w),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: lightGrey,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        value: selectedStatus,
                        onChanged: (newValue) {
                          setState(() {
                            selectedStatus = newValue!;
                          });
                        },
                        items:
                            status.map<DropdownMenuItem<String>>((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(
                              valueItem.tr,
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: RoundedYellowButton(
                      text: "filter_results".tr,
                      onTap: () {
                        Navigator.pop(context);
                        logsCubit!.emit(LogsInitialStates());
                        logsCubit!.getLogsItems(
                            logsCategoriesModel!.data!.rows![selectedTap].key
                                .toString(),
                            fromDate.toString().substring(0, 10),
                            toDate.toString().substring(0, 10),
                            selectedStatus);
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeTap({
    required int index,
    required String title,
    required String icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: GestureDetector(
        onTap: () {
          categoryKeyIndex = index;
          checkSelectedTap(index);
          logsCubit!.getLogsItems(
              logsCategoriesModel!.data!.rows![index].key.toString(),
              fromDate.toString().substring(0, 10),
              toDate.toString().substring(0, 10),
              selectedStatus);
        },
        child: Container(
          width: 120.w,
          height: 110.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: selectedTap == index ? mainColor : Colors.white,
              border: Border.all(color: mainColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 40.h,
                  color: selectedTap == index ? Colors.white : null,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Flexible(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: selectedTap == index ? Colors.white : mainColor),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

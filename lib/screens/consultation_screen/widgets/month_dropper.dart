import 'package:flutter/material.dart';
import 'package:istchrat/shared_components/colors.dart';

class MonthDropper extends StatefulWidget {
  const MonthDropper({Key? key}) : super(key: key);

  @override
  _MonthDropperState createState() => _MonthDropperState();
}

class _MonthDropperState extends State<MonthDropper> {
  final List<String> months = ["Jan", "Feb", "Mar"];
  String? value = "Feb";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: value,
          iconDisabledColor: mainColor,
          iconEnabledColor: mainColor,
          items: months
              .map((month) => DropdownMenuItem<String>(
            child: Text(
              month,
              style: const TextStyle(color: mainColor),
            ),
            value: month,
          ))
              .toList(),
          onChanged: (String? value) {
            setState(() {
              this.value = value;
            });
          }),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({Key? key}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final TextEditingController messageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageController,
      maxLines: 5,
      cursorColor: Colors.white,
      strutStyle: StrutStyle(leading: 0),
      obscureText: false,
      style: TextStyle(
        fontSize: 14.0,
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 5.0),
        hintText: 'Write your message here (Optional) ..',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

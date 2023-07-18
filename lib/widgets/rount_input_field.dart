import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final Color? cursorColor;
  final Color? iconColor;
  final Color? editTextBackgroundColor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final double? iconSize;
  final TextInputType? keyboardType;

  const RoundedInputField(
      { Key? key,
        this.hintText,
        this.icon = Icons.person,
        this.onChanged,
        this.textEditingController,
        this.cursorColor,
        this.iconColor,
        this.editTextBackgroundColor,
        this.hintStyle,
        this.textStyle,
        this.keyboardType,
        this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      //width: size.width * 0.8,
      decoration: BoxDecoration(
        color: editTextBackgroundColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        style: textStyle,
        controller: textEditingController,
        onChanged: onChanged,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          hintText: hintText,
          hintStyle: hintStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
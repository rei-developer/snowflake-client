import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.hintText,
    this.autofocus = false,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  final String? hintText;
  final bool autofocus;
  final Function(String value)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.r),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          fillColor: Colors.black,
          filled: true,
        ),
        style: TextStyle(fontSize: 14.r, color: Colors.white),
        cursorColor: Colors.white,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged?.call,
      );
}

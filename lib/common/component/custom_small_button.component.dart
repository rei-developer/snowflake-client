import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSmallButtonComponent extends StatelessWidget {
  const CustomSmallButtonComponent(this.body, {this.callback, Key? key}) : super(key: key);

  final Widget body;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: callback?.call,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 8.r),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: body,
        ),
      );
}

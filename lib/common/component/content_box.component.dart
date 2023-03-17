import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentBoxComponent extends StatefulWidget {
  const ContentBoxComponent(this.body, {Key? key}) : super(key: key);

  final Widget body;

  @override
  State<ContentBoxComponent> createState() => _ContentBoxComponentState();
}

class _ContentBoxComponentState extends State<ContentBoxComponent> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(10.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.r, sigmaY: 5.r),
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: widget.body,
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout(this.body, {Key? key}) : super(key: key);

  final Widget body;

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 32.r,
          titleSpacing: 0,
          leadingWidth: 0,
          title: Text(
            '테스트 게임',
            style: TextStyle(
              fontSize: 13.r,
              fontWeight: FontWeight.w400,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(bottom: false, child: widget.body),
        resizeToAvoidBottomInset: false,
      );
}

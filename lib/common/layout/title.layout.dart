import 'package:flutter/material.dart';

class TitleLayout extends StatefulWidget {
  const TitleLayout(this.body, {Key? key}) : super(key: key);

  final Widget body;

  @override
  State<TitleLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<TitleLayout> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: widget.body,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
      );
}

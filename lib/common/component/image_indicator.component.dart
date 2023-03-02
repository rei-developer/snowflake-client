import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/utils/go.util.dart';

void showImageIndicator(BuildContext context, {String? message, int? duration}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ImageIndicator(message: message, duration: duration),
    );

class _ImageIndicator extends ConsumerStatefulWidget {
  const _ImageIndicator({this.message, this.duration, Key? key}) : super(key: key);

  final String? message;
  final int? duration;

  @override
  ConsumerState<_ImageIndicator> createState() => _ImageIndicatorState();
}

class _ImageIndicatorState extends ConsumerState<_ImageIndicator> with TickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(Duration(seconds: widget.duration ?? 1), () => Go(context).pop());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.message != null) ...[
                SizedBox(height: 20.r),
                Text(
                  widget.message!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.r,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
}

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/util/asset_loader.dart';

void showLoadingIndicator(BuildContext context, {String? message}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _LoadingIndicator(message: message),
    );

class _LoadingIndicator extends ConsumerStatefulWidget {
  const _LoadingIndicator({this.message, Key? key}) : super(key: key);

  final String? message;

  @override
  ConsumerState<_LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends ConsumerState<_LoadingIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () => Future(() => false),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) => Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  ),
                  child: AssetLoader('image/common/loading.svg').image(),
                ),
                if (widget.message != null) ...[
                  SizedBox(height: 20.r),
                  Text(
                    widget.message!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}

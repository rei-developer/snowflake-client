import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/entry/provider/entry.provider.dart';
import 'package:snowflake_client/title/title.const.dart';
import 'package:snowflake_client/utils/asset_loader.dart';

class EntryContainer extends ConsumerStatefulWidget {
  const EntryContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<EntryContainer> createState() => _EntryContainerState();
}

class _EntryContainerState extends ConsumerState<EntryContainer> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => ref.read(entryControllerProvider(context)).entry(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Image.asset(
            'assets/${TitleBackgroundImage.TOWN.path}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) => Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                ),
                child: Transform.scale(
                  scale: 0.2.r,
                  child: AssetLoader('image/common/loading.svg').image(),
                ),
              ),
            ),
          ),
        ],
      );
}

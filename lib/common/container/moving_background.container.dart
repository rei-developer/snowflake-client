import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WallpaperCarouselContainer extends StatefulWidget {
  const WallpaperCarouselContainer(this.wallpapers, this.body, {Key? key}) : super(key: key);

  final List<String> wallpapers;
  final Widget body;

  @override
  State<WallpaperCarouselContainer> createState() => _WallpaperCarouselContainerState();
}

class _WallpaperCarouselContainerState extends State<WallpaperCarouselContainer>
    with TickerProviderStateMixin {
  int _imageCount = 0;
  bool _isChangedAnimationStatus = true;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      lowerBound: 0.5,
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.forward) {
          setState(
            () {
              if (++_imageCount >= widget.wallpapers.length) {
                _imageCount = 0;
              }
              _isChangedAnimationStatus = !_isChangedAnimationStatus;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 3),
            top: 0,
            left: _isChangedAnimationStatus ? 0 : -100.r,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/${widget.wallpapers[_imageCount]}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          SafeArea(child: widget.body),
        ],
      );
}

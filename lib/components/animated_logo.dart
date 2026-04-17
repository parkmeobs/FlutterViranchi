import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_application_1/constants/app_images.dart';


class AnimatedLogo extends StatefulWidget {
  final double logo;
  final double inner;
  final double outer;

  const AnimatedLogo({
    super.key,
    required this.logo,
    required this.inner,
    required this.outer,
  });

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController clockwiseController;
  late AnimationController anticlockwiseController;

  @override
  void initState() {
    super.initState();

    /// Clockwise
    clockwiseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    /// Anti-clockwise
    anticlockwiseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    clockwiseController.dispose();
    anticlockwiseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.outer,
      width: widget.outer,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 🔵 Outer rotating (clockwise)
          AnimatedBuilder(
            animation: clockwiseController,
            builder: (_, child) {
              return Transform.rotate(
                angle: clockwiseController.value * 2 * pi,
                child: child,
              );
            },
            child: Image.asset(
              AppImages.logoOuter,
              height: widget.outer,
              width: widget.outer,
              fit: BoxFit.contain,
            ),
          ),

          /// 🟢 Inner rotating (anticlockwise)
          AnimatedBuilder(
            animation: anticlockwiseController,
            builder: (_, child) {
              return Transform.rotate(
                angle: -anticlockwiseController.value * 2 * pi,
                child: child,
              );
            },
            child: Image.asset(
              AppImages.logoInner,
              height: widget.inner,
              width: widget.inner,
              fit: BoxFit.contain,
            ),
          ),

          /// 🟡 Center Logo (static)
          Image.asset(
            AppImages.logoCenter,
            height: widget.logo,
            width: widget.logo,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
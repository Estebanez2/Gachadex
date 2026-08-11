import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class AnimatedAppear extends StatelessWidget {
  const AnimatedAppear({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 0.04),
  });

  final Widget child;
  final Duration delay;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) {
      return child;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AppConstants.longAnimationDuration + delay,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final delayed = delay == Duration.zero
            ? value
            : ((value *
                              (AppConstants.longAnimationDuration + delay)
                                  .inMilliseconds -
                          delay.inMilliseconds) /
                      AppConstants.longAnimationDuration.inMilliseconds)
                  .clamp(0.0, 1.0);
        return Opacity(
          opacity: delayed,
          child: FractionalTranslation(
            translation: Offset.lerp(offset, Offset.zero, delayed)!,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

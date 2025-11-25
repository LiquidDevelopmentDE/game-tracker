import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeleton extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final bool fixLayoutBuilder;

  const AppSkeleton({
    super.key,
    required this.child,
    this.enabled = true,
    this.fixLayoutBuilder = false,
  });

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: PulseEffect(
        from: Colors.grey[800]!,
        to: Colors.grey[600]!,
        duration: const Duration(milliseconds: 800),
      ),
      enabled: widget.enabled,
      enableSwitchAnimation: true,
      switchAnimationConfig: SwitchAnimationConfig(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.linear,
        switchOutCurve: Curves.linear,
        transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
        layoutBuilder: !widget.fixLayoutBuilder
            ? AnimatedSwitcher.defaultLayoutBuilder
            : (Widget? currentChild, List<Widget> previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
      ),
      child: widget.child,
    );
  }
}

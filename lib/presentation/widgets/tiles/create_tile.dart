import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tallee/core/custom_theme.dart';

class CreateTile extends StatefulWidget {
  /// A tappable tile used in the create tab to start creating a new entity.
  /// - [icon]: The icon representing the entity to create.
  /// - [label]: The label describing the entity to create.
  /// - [onTap]: The callback invoked when the tile is tapped. It should return
  ///   a [Future] that completes when the pushed view is popped again. When
  ///   `null`, the tile is rendered in a disabled state.
  /// - [afterTap]: Optional callback invoked *after* the [onTap] future
  ///   completes, i.e. after the pushed view has been popped. Useful to switch
  ///   to another tab once the entity has been created.
  /// - [highlighted]: Whether the tile should be visually emphasized.
  const CreateTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.highlighted = false,
    this.afterTap,
  });

  final IconData icon;
  final String label;
  final Future<void> Function()? onTap;
  final bool highlighted;
  final VoidCallback? afterTap;

  @override
  State<CreateTile> createState() => _CreateTileState();
}

class _CreateTileState extends State<CreateTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get enabled => widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: enabled ? (_) => controller.forward() : null,
        onTapUp: enabled ? (_) async => await controller.reverse() : null,
        onTapCancel: enabled ? () => controller.reverse() : null,
        onTap: enabled
            ? () async {
                HapticFeedback.selectionClick();
                await widget.onTap!.call();
                if (!mounted) return;
                widget.afterTap?.call();
              }
            : null,
        child: Opacity(
          opacity: enabled ? 1.0 : 0.5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: widget.highlighted
                  ? CustomTheme.primaryColor.withValues(alpha: 0.1)
                  : CustomTheme.boxColor,
              border: Border.all(
                color: widget.highlighted
                    ? CustomTheme.primaryColor
                    : CustomTheme.boxBorderColor,
                width: widget.highlighted ? 2 : 1,
              ),
              borderRadius: CustomTheme.standardBorderRadiusAll,
            ),
            child: Expanded(
              child: Column(
                spacing: 4,
                children: [
                  // Icon container
                  Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.highlighted
                          ? CustomTheme.primaryColor
                          : CustomTheme.onBoxColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Icon(widget.icon, size: 45),
                  ),

                  // Label text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

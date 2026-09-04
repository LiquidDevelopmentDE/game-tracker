import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tallee/core/custom_theme.dart';

class CreateTile extends StatefulWidget {
  /// A tappable tile used in the create tab to start creating a new entity.
  /// - [icon]: The icon representing the entity to create.
  /// - [label]: The label describing the entity to create.
  /// - [onTap]: The callback invoked when the tile is tapped. When `null`,
  ///   the tile is rendered in a disabled state.
  /// - [highlighted]: Whether the tile should be visually emphasized.
  /// - [subtitle]: Optional secondary text shown below the label.
  const CreateTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.highlighted = false,
    this.subtitle,
  });

  /// The icon representing the entity to create.
  final IconData icon;

  /// The label describing the entity to create.
  final String label;

  /// The callback invoked when the tile is tapped. Disables the tile if `null`.
  final VoidCallback? onTap;

  /// Whether the tile should be visually emphasized.
  final bool highlighted;

  /// Optional secondary text shown below the label.
  final String? subtitle;

  @override
  State<CreateTile> createState() => _CreateTileState();
}

class _CreateTileState extends State<CreateTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _enabled => widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = widget.highlighted
        ? CustomTheme.primaryColor
        : CustomTheme.textColor;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _enabled ? (_) => _controller.forward() : null,
        onTapUp: _enabled
            ? (_) async {
                await _controller.reverse();
              }
            : null,
        onTapCancel: _enabled ? () => _controller.reverse() : null,
        onTap: _enabled
            ? () {
                HapticFeedback.selectionClick();
                widget.onTap!.call();
              }
            : null,
        child: Opacity(
          opacity: _enabled ? 1.0 : 0.4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: widget.highlighted
                  ? CustomTheme.primaryColor.withValues(alpha: 0.12)
                  : CustomTheme.boxColor,
              border: Border.all(
                color: widget.highlighted
                    ? CustomTheme.primaryColor
                    : CustomTheme.boxBorderColor,
                width: widget.highlighted ? 2 : 1,
              ),
              borderRadius: CustomTheme.standardBorderRadiusAll,
            ),
            child: widget.highlighted
                ? _buildHighlightedContent(accentColor)
                : _buildStandardContent(accentColor),
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightedContent(Color accentColor) {
    return Row(
      children: [
        _iconBadge(accentColor, size: 30, padding: 14),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  color: CustomTheme.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  widget.subtitle!,
                  style: const TextStyle(
                    color: CustomTheme.hintColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
        Icon(Icons.add_rounded, color: accentColor, size: 28),
      ],
    );
  }

  Widget _buildStandardContent(Color accentColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconBadge(accentColor, size: 26, padding: 12),
            const Icon(
              Icons.add_rounded,
              color: CustomTheme.hintColor,
              size: 22,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          widget.label,
          style: const TextStyle(
            color: CustomTheme.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            widget.subtitle!,
            style: const TextStyle(color: CustomTheme.hintColor, fontSize: 12),
            maxLines: 1,
          ),
        ],
      ],
    );
  }

  Widget _iconBadge(
    Color accentColor, {
    required double size,
    required double padding,
  }) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: widget.highlighted
            ? CustomTheme.primaryColor.withValues(alpha: 0.18)
            : CustomTheme.onBoxColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(widget.icon, color: accentColor, size: size),
    );
  }
}

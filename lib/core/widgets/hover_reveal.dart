import 'package:flutter/material.dart';

/// Desktop hover affordance: a slight scale and a subtle overlay.
/// Hover is additive only — nothing is hidden behind it on touch devices.
class HoverReveal extends StatefulWidget {
  const HoverReveal({
    super.key,
    required this.builder,
    this.scale = 1.03,
    this.enabled = true,
    this.onTap,
  });

  final Widget Function(BuildContext context, bool hovered) builder;
  final double scale;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  State<HoverReveal> createState() => _HoverRevealState();
}

class _HoverRevealState extends State<HoverReveal> {
  bool _hovered = false;

  void _set(bool value) {
    if (!widget.enabled || _hovered == value) return;
    setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = AnimatedScale(
      scale: _hovered ? widget.scale : 1,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      child: widget.builder(context, _hovered),
    );

    return MouseRegion(
      cursor: widget.onTap == null
          ? MouseCursor.defer
          : SystemMouseCursors.click,
      onEnter: (_) => _set(true),
      onExit: (_) => _set(false),
      child: widget.onTap == null
          ? content
          : GestureDetector(onTap: widget.onTap, child: content),
    );
  }
}

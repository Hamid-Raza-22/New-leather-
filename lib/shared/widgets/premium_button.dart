import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

enum PremiumButtonVariant { solidDark, solidLight, outlineDark, outlineLight }

/// Squared, letter-spaced button used throughout the site.
class PremiumButton extends StatefulWidget {
  const PremiumButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PremiumButtonVariant.solidDark,
    this.trailingArrow = false,
    this.expand = false,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final PremiumButtonVariant variant;
  final bool trailingArrow;
  final bool expand;
  final bool busy;

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _hovered = false;

  bool get _isLight =>
      widget.variant == PremiumButtonVariant.solidLight ||
      widget.variant == PremiumButtonVariant.outlineLight;

  bool get _isOutline =>
      widget.variant == PremiumButtonVariant.outlineDark ||
      widget.variant == PremiumButtonVariant.outlineLight;

  @override
  Widget build(BuildContext context) {
    final Color base = _isLight ? AppColors.ivory : AppColors.charcoal;
    final Color contrast = _isLight ? AppColors.charcoal : AppColors.ivory;

    final Color background = _isOutline
        ? (_hovered ? base : Colors.transparent)
        : (_hovered ? base.withValues(alpha: 0.86) : base);
    final Color foreground = _isOutline
        ? (_hovered ? contrast : base)
        : contrast;

    final Widget child = AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: base, width: 1),
      ),
      child: Row(
        mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.busy) ...<Widget>[
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 1.4,
                valueColor: AlwaysStoppedAnimation<Color>(foreground),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Text(
              widget.label,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.button(context).copyWith(color: foreground),
            ),
          ),
          if (widget.trailingArrow) ...<Widget>[
            const SizedBox(width: 12),
            AnimatedSlide(
              offset: Offset(_hovered ? 0.25 : 0, 0),
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOut,
              child: Text(
                '\u2192',
                style: AppTextStyles.button(context)
                    .copyWith(color: foreground, fontSize: 14),
              ),
            ),
          ],
        ],
      ),
    );

    return Semantics(
      button: true,
      label: widget.label,
      enabled: widget.onPressed != null,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: FocusableActionDetector(
          onShowFocusHighlight: (bool value) =>
              setState(() => _hovered = value),
          child: GestureDetector(
            onTap: widget.busy ? null : widget.onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/models/gallery_item.dart';

/// Horizontal, keyboard-reachable category filter. `null` means "ALL".
class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final GalleryCategory? selected;
  final ValueChanged<GalleryCategory?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Gallery categories',
      child: Wrap(
        spacing: 28,
        runSpacing: 12,
        children: <Widget>[
          _FilterChipLabel(
            label: 'ALL',
            active: selected == null,
            onTap: () => onChanged(null),
          ),
          for (final GalleryCategory category in GalleryCategory.values)
            _FilterChipLabel(
              label: category.label,
              active: selected == category,
              onTap: () => onChanged(category),
            ),
        ],
      ),
    );
  }
}

class _FilterChipLabel extends StatefulWidget {
  const _FilterChipLabel({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_FilterChipLabel> createState() => _FilterChipLabelState();
}

class _FilterChipLabelState extends State<_FilterChipLabel> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final Color color = widget.active || _focused
        ? AppColors.ivory
        : AppColors.neutral500;

    return Semantics(
      button: true,
      selected: widget.active,
      label: widget.label,
      child: FocusableActionDetector(
        onShowFocusHighlight: (bool value) => setState(() => _focused = value),
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onTap();
              return null;
            },
          ),
        },
        mouseCursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.label,
                style: AppTextStyles.sans(
                  fontSize: 12,
                  letterSpacing: 1.8,
                  color: color,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                height: 1,
                width: widget.active ? widget.label.length * 8.0 : 0,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

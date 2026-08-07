import 'package:flutter/material.dart';

import '../../app/theme/app_text_styles.dart';

/// Navbar link with an underline that draws in on hover or keyboard focus.
class NavLink extends StatefulWidget {
  const NavLink({
    super.key,
    required this.label,
    required this.onTap,
    required this.color,
    this.active = false,
    this.fontSize = 12,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool active;
  final double fontSize;

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _highlighted = false;

  @override
  Widget build(BuildContext context) {
    final bool underlined = _highlighted || widget.active;

    return Semantics(
      link: true,
      label: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _highlighted = true),
        onExit: (_) => setState(() => _highlighted = false),
        child: FocusableActionDetector(
          onShowFocusHighlight: (bool value) =>
              setState(() => _highlighted = value),
          actions: <Type, Action<Intent>>{
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                widget.onTap();
                return null;
              },
            ),
          },
          child: GestureDetector(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.label,
                    style: AppTextStyles.navLink(context).copyWith(
                      color: widget.color,
                      fontSize: widget.fontSize,
                    ),
                  ),
                  const SizedBox(height: 5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOut,
                    height: 1,
                    width: underlined ? widget.label.length * 8.0 : 0,
                    color: widget.color,
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

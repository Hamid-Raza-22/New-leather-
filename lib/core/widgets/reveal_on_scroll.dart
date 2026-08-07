import 'package:flutter/material.dart';

/// Fades and lifts its child into view the first time it approaches the
/// viewport. Falls back to revealing immediately if it is not inside a
/// scrollable.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 32,
    this.duration = const Duration(milliseconds: 700),
  });

  final Widget child;
  final Duration delay;
  final double offset;
  final Duration duration;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final Animation<double> _opacity = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: Offset(0, widget.offset / 100),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  ScrollPosition? _position;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _attach());
  }

  void _attach() {
    if (!mounted) return;
    _position = Scrollable.maybeOf(context)?.position;
    if (_position == null) {
      _reveal();
      return;
    }
    _position!.addListener(_onScroll);
    _onScroll();
  }

  void _onScroll() {
    if (_revealed || !mounted) return;
    final RenderObject? box = context.findRenderObject();
    if (box is! RenderBox || !box.attached) return;
    final double top = box.localToGlobal(Offset.zero).dy;
    final double viewport = MediaQuery.sizeOf(context).height;
    if (top < viewport * 0.92) _reveal();
  }

  void _reveal() {
    if (_revealed) return;
    _revealed = true;
    _position?.removeListener(_onScroll);
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future<void>.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

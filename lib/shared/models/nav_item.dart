import 'package:flutter/foundation.dart';

@immutable
class NavItem {
  const NavItem({required this.label, required this.route});

  final String label;
  final String route;
}

import 'package:flutter/widgets.dart';

import '../../app/theme/app_breakpoints.dart';
import '../../app/theme/app_spacing.dart';

enum DeviceType { mobile, tablet, desktop }

/// Small, dependency-free responsive helper.
///
/// Mobile is treated as its own layout target, not a scaled-down desktop.
class Responsive {
  const Responsive._();

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) =>
      width(context) < AppBreakpoints.mobile;

  static bool isTablet(BuildContext context) {
    final double w = width(context);
    return w >= AppBreakpoints.mobile && w < AppBreakpoints.tablet;
  }

  static bool isDesktop(BuildContext context) =>
      width(context) >= AppBreakpoints.tablet;

  static bool isWide(BuildContext context) =>
      width(context) >= AppBreakpoints.desktop;

  static DeviceType deviceType(BuildContext context) {
    if (isMobile(context)) return DeviceType.mobile;
    if (isTablet(context)) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  /// Returns the value matching the current device type.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.desktop:
        return desktop;
    }
  }

  static double gutter(BuildContext context) => value<double>(
        context,
        mobile: AppSpacing.gutterMobile,
        tablet: AppSpacing.gutterTablet,
        desktop: AppSpacing.gutterDesktop,
      );

  static EdgeInsets pagePadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: gutter(context));

  static double sectionSpacing(BuildContext context) => value<double>(
        context,
        mobile: AppSpacing.sectionMobile,
        tablet: 96,
        desktop: AppSpacing.section,
      );

  /// Number of grid columns for the gallery and card grids.
  static int gridColumns(BuildContext context) {
    final double w = width(context);
    if (w < 600) return 1;
    if (w < AppBreakpoints.mobile) return 2;
    if (w < AppBreakpoints.tablet) return 2;
    if (w < AppBreakpoints.desktop) return 3;
    if (w < AppBreakpoints.wide) return 3;
    return 4;
  }
}

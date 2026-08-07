/// Breakpoints tuned for 360/375/390/414/600/768/1024/1280/1440/1920+ widths.
class AppBreakpoints {
  const AppBreakpoints._();

  /// Below this width the mobile layout is used.
  static const double mobile = 768;

  /// From [mobile] up to this width the tablet layout is used.
  static const double tablet = 1024;

  /// From [tablet] upwards the desktop layout is used.
  static const double desktop = 1280;

  /// Above this width content stops growing and is centred.
  static const double wide = 1920;
}

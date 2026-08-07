import 'package:flutter/services.dart';

/// Sets the browser document title for the current page.
class DocumentTitle {
  const DocumentTitle._();

  static const String suffix = 'New Leather';

  static void set(String pageTitle) {
    final String title =
        pageTitle.isEmpty ? suffix : '$pageTitle \u2014 $suffix';
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(label: title, primaryColor: 0xFF0B0B0B),
    );
  }
}

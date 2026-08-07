import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Thin wrapper around url_launcher so call sites stay declarative.
class Launcher {
  const Launcher._();

  static Future<bool> open(String url, {bool newTab = true}) async {
    final Uri uri = Uri.parse(url);
    try {
      return await launchUrl(
        uri,
        mode: newTab
            ? LaunchMode.externalApplication
            : LaunchMode.platformDefault,
        webOnlyWindowName: newTab ? '_blank' : '_self',
      );
    } catch (error) {
      debugPrint('Could not open $url: $error');
      return false;
    }
  }

  static Future<bool> email(String mailto) => open(mailto, newTab: false);
}

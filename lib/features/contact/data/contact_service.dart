import 'dart:async';

import 'package:flutter/foundation.dart';

import 'contact_inquiry.dart';

class ContactSubmissionException implements Exception {
  const ContactSubmissionException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Transport abstraction for contact inquiries.
///
/// No backend is wired up: doing so requires an endpoint and credentials the
/// client must provide. See `docs/contact-form-setup.md` for the two supported
/// integration paths.
abstract class ContactService {
  const ContactService();

  Future<void> submit(ContactInquiry inquiry);
}

/// Default implementation used until a real endpoint is configured.
///
/// It validates that a destination exists and otherwise reports that the
/// backend is not configured, so the UI never pretends a message was sent.
class UnconfiguredContactService extends ContactService {
  const UnconfiguredContactService();

  @override
  Future<void> submit(ContactInquiry inquiry) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (kDebugMode) {
      debugPrint('Contact inquiry (not sent): ${inquiry.toJson()}');
    }
    throw const ContactSubmissionException(
      'The inquiry form is not connected to a mail service yet. '
      'Please email us directly and we will reply.',
    );
  }
}

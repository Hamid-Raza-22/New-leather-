import 'package:flutter/foundation.dart';

@immutable
class JournalEntry {
  const JournalEntry({
    required this.title,
    required this.excerpt,
    this.date,
  });

  final String title;
  final String excerpt;
  final DateTime? date;
}

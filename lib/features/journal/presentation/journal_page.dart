import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/models/journal_entry.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';

/// Structure only. No articles are invented; [entries] is empty until the
/// client supplies real content.
class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  static const List<JournalEntry> entries = <JournalEntry>[];

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      route: AppRoutes.journal,
      navbarStartsTransparent: true,
      children: <Widget>[
        const PageIntro(
          eyebrow: 'JOURNAL',
          title: 'Journal.',
          lead:
              'Notes on material, research and the way leather is looked at. '
              'Published as content becomes available.',
        ),
        Section(
          child: entries.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    SectionHeading(
                      eyebrow: 'STATUS',
                      headline: 'No entries published yet.',
                      body:
                          'The journal template is in place. Entries appear here '
                          'once written and approved.',
                    ),
                    SizedBox(height: AppSpacing.xl),
                    ConfirmationNote(
                      text: 'Journal content: ${AppStrings.needsConfirmation}',
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (final JournalEntry entry in entries)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                        child: SectionHeading(
                          headline: entry.title,
                          body: entry.excerpt,
                        ),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}

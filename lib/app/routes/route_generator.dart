import 'package:flutter/material.dart';

import '../../features/about/presentation/about_page.dart';
import '../../features/applications/presentation/applications_page.dart';
import '../../features/collections/presentation/collections_page.dart';
import '../../features/contact/presentation/contact_page.dart';
import '../../features/expertise/presentation/expertise_page.dart';
import '../../features/gallery/presentation/gallery_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/journal/presentation/journal_page.dart';
import '../../features/leather/presentation/leather_page.dart';
import '../../features/team/presentation/team_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final String name = settings.name ?? AppRoutes.home;
    final Widget page = _pageFor(name);

    return PageRouteBuilder<void>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  static Widget _pageFor(String name) {
    switch (name) {
      case AppRoutes.about:
        return const AboutPage();
      case AppRoutes.leather:
        return const LeatherPage();
      case AppRoutes.expertise:
        return const ExpertisePage();
      case AppRoutes.applications:
        return const ApplicationsPage();
      case AppRoutes.collections:
        return const CollectionsPage();
      case AppRoutes.gallery:
        return const GalleryPage();
      case AppRoutes.team:
        return const TeamPage();
      case AppRoutes.journal:
        return const JournalPage();
      case AppRoutes.contact:
        return const ContactPage();
      case AppRoutes.home:
      default:
        return const HomePage();
    }
  }
}

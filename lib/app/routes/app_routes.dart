import '../../shared/models/nav_item.dart';

class AppRoutes {
  const AppRoutes._();

  static const String home = '/';
  static const String about = '/about';
  static const String leather = '/leather';
  static const String expertise = '/expertise';
  static const String applications = '/applications';
  static const String collections = '/collections';
  static const String gallery = '/gallery';
  static const String team = '/team';
  static const String journal = '/journal';
  static const String contact = '/contact';

  /// Document titles, set per page.
  static const Map<String, String> titles = <String, String>{
    home: 'Leather, shaped by experience',
    about: 'About',
    leather: 'The Material',
    expertise: 'Expertise',
    applications: 'Applications',
    collections: 'Collections',
    gallery: 'Gallery',
    team: 'The People Behind the Material',
    journal: 'Journal',
    contact: 'Contact',
  };

  /// Primary navigation shown in the navbar and mobile menu.
  static const List<NavItem> primaryNav = <NavItem>[
    NavItem(label: 'ABOUT', route: about),
    NavItem(label: 'LEATHER', route: leather),
    NavItem(label: 'EXPERTISE', route: expertise),
    NavItem(label: 'APPLICATIONS', route: applications),
    NavItem(label: 'GALLERY', route: gallery),
    NavItem(label: 'CONTACT', route: contact),
  ];

  /// Full site index used by the footer and the mobile menu.
  static const List<NavItem> allPages = <NavItem>[
    NavItem(label: 'HOME', route: home),
    NavItem(label: 'ABOUT', route: about),
    NavItem(label: 'LEATHER', route: leather),
    NavItem(label: 'EXPERTISE', route: expertise),
    NavItem(label: 'APPLICATIONS', route: applications),
    NavItem(label: 'COLLECTIONS', route: collections),
    NavItem(label: 'GALLERY', route: gallery),
    NavItem(label: 'TEAM', route: team),
    NavItem(label: 'JOURNAL', route: journal),
    NavItem(label: 'CONTACT', route: contact),
  ];
}

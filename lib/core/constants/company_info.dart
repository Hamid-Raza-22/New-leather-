/// Verified public company information.
///
/// Nothing in this file may be invented. Values that are not publicly verified
/// are marked with [clientConfirmationRequired] and must be confirmed by the
/// client before publication.
class CompanyInfo {
  const CompanyInfo._();

  static const String clientConfirmationRequired =
      '[CLIENT CONFIRMATION REQUIRED]';

  static const String legalName = 'New Leather srl';
  static const String displayName = 'NEW LEATHER';

  static const String street = 'Via Veregrense 145';
  static const String postalCode = '63812';
  static const String city = 'Montegranaro';
  static const String country = 'Italy';
  static const String addressSingleLine =
      '$street, $postalCode $city, $country';

  static const String email = 'info@newleathersrl.it';
  static const String emailUri = 'mailto:$email';

  static const String instagramHandle = '@new_leathersrl';
  static const String instagramUrl =
      'https://www.instagram.com/new_leathersrl/';

  static const String mapsUrl =
      'https://www.google.com/maps/search/?api=1&query='
      'Via+Veregrense+145,+63812+Montegranaro,+Italy';

  /// No public phone number has been confirmed by the client for the website.
  static const String? phone = null;

  static String copyright(DateTime now) =>
      '\u00A9 ${now.year} $legalName. All rights reserved.';
}

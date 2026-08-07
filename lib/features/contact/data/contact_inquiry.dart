import 'package:flutter/foundation.dart';

@immutable
class ContactInquiry {
  const ContactInquiry({
    required this.name,
    required this.email,
    required this.message,
    this.company,
    this.phone,
    this.country,
  });

  final String name;
  final String email;
  final String message;
  final String? company;
  final String? phone;
  final String? country;

  Map<String, String> toJson() => <String, String>{
        'name': name,
        'email': email,
        'message': message,
        if (company != null && company!.isNotEmpty) 'company': company!,
        if (phone != null && phone!.isNotEmpty) 'phone': phone!,
        if (country != null && country!.isNotEmpty) 'country': country!,
      };
}

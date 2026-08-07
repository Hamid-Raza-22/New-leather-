/// Form validation used by the contact form.
class Validators {
  const Validators._();

  static final RegExp _email = RegExp(
    r'^[\w.!#$%&*+/=?^`{|}~-]+@[\w-]+(\.[\w-]+)+$',
  );

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required.';
    }
    return null;
  }

  static String? name(String? value) => required(value, field: 'Name');

  static String? message(String? value) => required(value, field: 'Message');

  static String? email(String? value) {
    final String trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) return 'Email is required.';
    if (!_email.hasMatch(trimmed)) return 'Enter a valid email address.';
    return null;
  }
}

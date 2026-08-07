# Contact form setup

The contact form is fully implemented in the UI — fields, validation, and
loading / success / error states — but it is **not connected to a backend**.
Wiring a real transport requires an endpoint and credentials that only the
client can provide, so no service is configured and no message is silently
dropped: submitting currently surfaces an explicit error that directs the
visitor to email the company.

## Files

| File | Role |
| --- | --- |
| `lib/features/contact/data/contact_inquiry.dart` | Immutable payload (`name`, `company`, `email`, `phone`, `country`, `message`) |
| `lib/features/contact/data/contact_service.dart` | `ContactService` abstraction + `UnconfiguredContactService` default |
| `lib/features/contact/presentation/widgets/contact_form.dart` | Form, validation and UI states |

## Validation rules

| Field | Rule |
| --- | --- |
| Name | Required |
| Company | Optional |
| Email | Required, must be a valid address |
| Phone | Optional |
| Country | Optional |
| Message | Required |

## Connecting a backend

Implement `ContactService` and pass it into `ContactForm(service: ...)`.

```dart
class HttpContactService extends ContactService {
  const HttpContactService(this.endpoint);

  final Uri endpoint;

  @override
  Future<void> submit(ContactInquiry inquiry) async {
    final http.Response response = await http.post(
      endpoint,
      headers: const <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(inquiry.toJson()),
    );
    if (response.statusCode >= 400) {
      throw const ContactSubmissionException(
        'We could not send your inquiry. Please email us directly.',
      );
    }
  }
}
```

Add `http` to `pubspec.yaml` when this path is taken.

### Option A — transactional email API (recommended)

A provider such as Postmark, Resend, SendGrid or Mailgun, called from a small
serverless function.

**The API key must never live in the Flutter Web bundle** — anything shipped to
the browser is public. Route submissions through a function (Cloudflare Worker,
Vercel/Netlify function, Cloud Run) that holds the key server-side.

Required from the client:

1. Provider account and API key (stored as a server-side secret).
2. A verified sender domain or address.
3. The destination inbox (presumably `info@newleathersrl.it`).

### Option B — hosted form endpoint

Formspree, Basin, Web3Forms or similar. Simpler, no function to deploy; the
form posts directly to the provider's URL.

Required from the client: an account and the form endpoint URL. Enable the
provider's spam protection.

## Before launch

- [ ] Choose option A or B and obtain credentials from the client.
- [ ] Add spam protection (honeypot field, rate limiting, or provider CAPTCHA).
- [ ] Confirm the destination inbox and, if needed, an auto-reply.
- [ ] Confirm GDPR handling: privacy notice, consent text, retention period.
      Nothing is stated on the site about data handling until confirmed.
- [ ] Replace `UnconfiguredContactService` in
      `lib/features/contact/presentation/contact_page.dart`'s form instance.

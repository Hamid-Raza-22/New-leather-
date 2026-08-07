import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/constants/company_info.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/utils/launcher.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/premium_button.dart';
import '../../data/contact_inquiry.dart';
import '../../data/contact_service.dart';

enum FormStatus { idle, loading, success, error }

class ContactForm extends StatefulWidget {
  const ContactForm({super.key, this.service = const UnconfiguredContactService()});

  final ContactService service;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _company = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _message = TextEditingController();

  final ValueNotifier<FormStatus> _status =
      ValueNotifier<FormStatus>(FormStatus.idle);
  String? _errorMessage;

  @override
  void dispose() {
    for (final TextEditingController controller in <TextEditingController>[
      _name,
      _company,
      _email,
      _phone,
      _country,
      _message,
    ]) {
      controller.dispose();
    }
    _status.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    _status.value = FormStatus.loading;
    _errorMessage = null;

    try {
      await widget.service.submit(
        ContactInquiry(
          name: _name.text.trim(),
          email: _email.text.trim(),
          message: _message.text.trim(),
          company: _company.text.trim(),
          phone: _phone.text.trim(),
          country: _country.text.trim(),
        ),
      );
      _formKey.currentState?.reset();
      for (final TextEditingController controller in <TextEditingController>[
        _name,
        _company,
        _email,
        _phone,
        _country,
        _message,
      ]) {
        controller.clear();
      }
      _status.value = FormStatus.success;
    } on ContactSubmissionException catch (error) {
      _errorMessage = error.message;
      _status.value = FormStatus.error;
    } catch (_) {
      _errorMessage = 'Something went wrong. Please try again or email us.';
      _status.value = FormStatus.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _pair(
            isMobile,
            _field(
              controller: _name,
              label: 'NAME *',
              validator: Validators.name,
              textInputAction: TextInputAction.next,
            ),
            _field(
              controller: _company,
              label: 'COMPANY',
              textInputAction: TextInputAction.next,
            ),
          ),
          _pair(
            isMobile,
            _field(
              controller: _email,
              label: 'EMAIL *',
              validator: Validators.email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            _field(
              controller: _phone,
              label: 'PHONE',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
          ),
          _field(
            controller: _country,
            label: 'COUNTRY',
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.lg),
          _field(
            controller: _message,
            label: 'MESSAGE *',
            validator: Validators.message,
            maxLines: 5,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: AppSpacing.xl),
          ValueListenableBuilder<FormStatus>(
            valueListenable: _status,
            builder: (BuildContext context, FormStatus status, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PremiumButton(
                    label: 'SEND AN INQUIRY',
                    trailingArrow: true,
                    busy: status == FormStatus.loading,
                    onPressed: status == FormStatus.loading ? null : _submit,
                  ),
                  if (status == FormStatus.success) ...<Widget>[
                    const SizedBox(height: AppSpacing.md),
                    _StatusMessage(
                      text: 'Thank you. Your inquiry has been sent.',
                      color: AppColors.success,
                    ),
                  ],
                  if (status == FormStatus.error) ...<Widget>[
                    const SizedBox(height: AppSpacing.md),
                    _StatusMessage(
                      text: _errorMessage ?? 'Something went wrong.',
                      color: AppColors.error,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    PremiumButton(
                      label: 'EMAIL NEW LEATHER',
                      variant: PremiumButtonVariant.outlineDark,
                      onPressed: () => Launcher.email(CompanyInfo.emailUri),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _pair(bool isMobile, Widget first, Widget second) {
    if (isMobile) {
      return Column(
        children: <Widget>[
          first,
          const SizedBox(height: AppSpacing.lg),
          second,
          const SizedBox(height: AppSpacing.lg),
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: first),
          const SizedBox(width: AppSpacing.xl),
          Expanded(child: second),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int maxLines = 1,
  }) {
    return Semantics(
      textField: true,
      label: label.replaceAll(' *', ' (required)'),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        style: AppTextStyles.body(context).copyWith(color: AppColors.charcoal),
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

class _StatusMessage extends StatelessWidget {
  const _StatusMessage({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(border: Border.all(color: color)),
        child: Text(
          text,
          style: AppTextStyles.body(context).copyWith(color: color),
        ),
      ),
    );
  }
}

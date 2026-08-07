import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_leather/app/app.dart';
import 'package:new_leather/app/routes/app_routes.dart';
import 'package:new_leather/app/routes/route_generator.dart';
import 'package:new_leather/core/constants/app_strings.dart';
import 'package:new_leather/core/constants/company_info.dart';
import 'package:new_leather/core/utils/validators.dart';

void main() {
  testWidgets('home page renders the hero headline', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const NewLeatherApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.text(AppStrings.heroHeadline), findsOneWidget);
    expect(find.text(AppStrings.heroSubline), findsOneWidget);
  });

  testWidgets('every route builds', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    for (final String route in AppRoutes.titles.keys) {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: route,
          onGenerateRoute: RouteGenerator.onGenerateRoute,
        ),
      );
      await tester.pump(const Duration(seconds: 2));
      expect(tester.takeException(), isNull, reason: 'route $route');
    }
  });

  test('email validation accepts and rejects the expected shapes', () {
    expect(Validators.email('info@newleathersrl.it'), isNull);
    expect(Validators.email('not-an-email'), isNotNull);
    expect(Validators.email(''), isNotNull);
    expect(Validators.name('  '), isNotNull);
    expect(Validators.message('Hello'), isNull);
  });

  test('copyright year is dynamic', () {
    expect(
      CompanyInfo.copyright(DateTime(2031)),
      '\u00A9 2031 New Leather srl. All rights reserved.',
    );
  });
}

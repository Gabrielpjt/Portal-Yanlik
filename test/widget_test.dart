// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portal_layanan_publik_mobile/app/app.dart';

void main() {
  testWidgets('App should build without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app renders
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Main navigation should have 4 tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify navigation items exist (looking for navigation icons)
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.search), findsWidgets);
    expect(find.byIcon(Icons.dashboard_customize), findsOneWidget);
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
  });

  testWidgets('Home page should display search bar', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify search bar exists
    expect(
      find.text('Layanan apa yang Anda butuhkan hari ini?'),
      findsOneWidget,
    );
    expect(find.text('Cara Perpanjang SIM'), findsOneWidget);
  });

  testWidgets('Sidebar "Profil Anda" visibility depends on login state', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // 1. Open the drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // 2. Verify "Profil Anda" is not visible (since not logged in)
    expect(find.text('Profil Anda'), findsNothing);
    expect(find.text('Akun Saya'), findsNothing);
    expect(find.text('Keluar Akun'), findsNothing);

    // Close the drawer by tapping the close button
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // 3. Go to profile tab (index 3) to log in
    await tester.tap(find.byIcon(Icons.account_circle));
    await tester.pumpAndSettle();

    // 4. Verify we are on the login page and tap "Masuk ke akun IKD"
    expect(find.text('Masuk ke akun Anda'), findsOneWidget);
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();
    final buttonFinder = find.text('Masuk ke akun IKD');
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // 5. Verify we are now logged in (ProfilePage is displayed)
    expect(find.text('Ahmad Andrawan'), findsOneWidget);

    // 6. Navigate back to Home tab (index 0) so we can open the drawer
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();

    // 7. Open the drawer again
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // 8. Verify "Profil Anda" section is now visible
    expect(find.text('Profil Anda'), findsOneWidget);
    expect(find.text('Akun Saya'), findsOneWidget);
    expect(find.text('Keluar Akun'), findsOneWidget);

    // 9. Tap "Keluar Akun" in the drawer to log out
    final logoutButton = find.text('Keluar Akun');
    await tester.ensureVisible(logoutButton);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();

    // 10. Verify we are logged out (should be redirected to home tab and drawer closed/open again)
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.text('Profil Anda'), findsNothing);
  });

  testWidgets('Header "Masuk" button switches to profile tab and logging in works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // 1. Verify we are on home tab (index 0) and Masuk button is visible
    expect(find.text('Masuk'), findsOneWidget);

    // 2. Tap "Masuk" button in the header
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    // 3. Verify we have switched to the Profile tab and see the login page
    expect(find.text('Masuk ke akun Anda'), findsOneWidget);

    // 4. Tap "Masuk ke akun IKD"
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Masuk ke akun IKD'));
    await tester.pumpAndSettle();

    // 5. Verify we are logged in (ProfilePage is displayed) and "Masuk" button is gone from header
    expect(find.text('Ahmad Andrawan'), findsOneWidget);
    expect(find.text('Masuk'), findsNothing);

    // 6. Open drawer and check if "Profil Anda" is visible
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.text('Profil Anda'), findsOneWidget);
  });
}

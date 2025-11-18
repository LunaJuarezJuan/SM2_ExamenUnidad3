import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import '../lib/views/login_view.dart';

// FakeAuth simple para inyectar en LoginView
class FakeAuth {
  bool isLoading = false;
  String? errorMessage;
  bool isAdmin = false;

  bool loginCalled = false;
  String? lastEmail;
  String? lastPassword;

  Future<bool> login(String email, String password) async {
    loginCalled = true;
    lastEmail = email;
    lastPassword = password;
    // Simular pequeña latencia
    await Future.delayed(Duration(milliseconds: 10));
    return errorMessage == null;
  }
}

void main() {
  // Asegura bindings para widget tests
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LoginView muestra título y campos', (WidgetTester tester) async {
    final fakeAuth = FakeAuth();

    await tester.pumpWidget(MaterialApp(home: LoginView(authOverride: fakeAuth)));
    await tester.pumpAndSettle();

    expect(find.text('Control de Acceso NFC'), findsOneWidget);
    expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
  });

  testWidgets('LoginView muestra mensaje de error cuando auth.errorMessage no es null',
      (WidgetTester tester) async {
    final fakeAuth = FakeAuth();
    fakeAuth.errorMessage = 'Credenciales inválidas';

    await tester.pumpWidget(MaterialApp(home: LoginView(authOverride: fakeAuth)));
    await tester.pumpAndSettle();

    expect(find.text('Credenciales inválidas'), findsOneWidget);
  });

  testWidgets('Al pulsar Iniciar Sesión se llama a login del auth override',
      (WidgetTester tester) async {
    final fakeAuth = FakeAuth();

    await tester.pumpWidget(MaterialApp(home: LoginView(authOverride: fakeAuth)));
    await tester.pumpAndSettle();

    // Rellenar campos: encuentra TextFormField por orden (email, password)
    final emailField = find.byType(TextFormField).at(0);
    final passField = find.byType(TextFormField).at(1);

    await tester.enterText(emailField, 'user@example.com');
    await tester.enterText(passField, 'password123');
    await tester.pump();

    final loginButton = find.text('Iniciar Sesión');
    expect(loginButton, findsOneWidget);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(fakeAuth.loginCalled, isTrue);
    expect(fakeAuth.lastEmail, 'user@example.com');
    expect(fakeAuth.lastPassword, 'password123');
  });
}

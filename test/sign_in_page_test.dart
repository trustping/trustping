// import 'dart:async';

// import 'package:trust_ping_app/app/sign_in/sign_in_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:trust_ping_app/routing/router.gr.dart';
// import 'package:trust_ping_app/services/firebase_auth_service.dart';

// import 'mocks.dart';

void main() {}
//   MockAuthService mockAuthService;
//   MockNavigatorObserver mockNavigatorObserver;
//   StreamController<User> onAuthStateChangedController;

//   setUp(() {
//     mockAuthService = MockAuthService();
//     mockNavigatorObserver = MockNavigatorObserver();
//     onAuthStateChangedController = StreamController<User>();
//   });

//   tearDown(() {
//     onAuthStateChangedController.close();
//   });

//   Future<void> pumpSignInPage(WidgetTester tester) async {
//     await tester.pumpWidget(
//       MultiProvider(
//         providers: [
//           Provider<FirebaseAuthService>(
//             create: (_) => mockAuthService,
//           ),
//         ],
//         child: MaterialApp(
//           home: SignInPageBuilder(),
//           onGenerateRoute: Router.onGenerateRoute,
//           navigatorObservers: [mockNavigatorObserver],
//         ),
//       ),
//     );
//     // didPush is called once when the widget is first built
//     verify(mockNavigatorObserver.didPush(any, any)).called(1);
//   }

//   testWidgets('email & password navigation', (WidgetTester tester) async {
//     await pumpSignInPage(tester);

//     final emailPasswordButton = find.byKey(SignInPage.emailPasswordButtonKey);
//     expect(emailPasswordButton, findsOneWidget);

//     await tester.tap(emailPasswordButton);
//     await tester.pumpAndSettle();

//     verify(mockNavigatorObserver.didPush(any, any)).called(1);
//   });
// }

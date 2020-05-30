import 'package:auto_route/auto_route.dart';
import 'package:trust_ping_app/app/auth_widget_builder.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/services/settings_service.dart';

import 'app/home/models/user.dart';

void main() {
  // runApp(MyAppDummy());
  runApp(
    MyApp(
      authServiceBuilder: (_) => FirebaseAuthService(),
      databaseBuilder: (_, String userID) => FirestoreDatabase(userID: userID),
    ),
  );
}

/// Top level widget structure for sign in and providing services
///   [MyApp]
///   [MultiProvider] providing [FirebaseAuthService]
///   [AuthWidgetBuilder]
///   [MultiProvider] providing [User] [FirestoreDatabase]
///   [MaterialApp]
///   [ExtendedNavigator] for all things routing
///   [LandingPage]
///   [ChatPage] or [SignInPageBuilder]
class MyApp extends StatelessWidget {
  const MyApp({Key key, this.authServiceBuilder, this.databaseBuilder})
      : super(key: key);
  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirebaseAuthService Function(BuildContext context) authServiceBuilder;
  final FirestoreDatabase Function(BuildContext context, String userID)
      databaseBuilder;

  @override
  Widget build(BuildContext context) {
    // MultiProvider for top-level services that don't depend on any runtime values (e.g. userID)
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: authServiceBuilder),
      ],
      child: AuthWidgetBuilder(
        databaseBuilder: databaseBuilder,
        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          return MaterialApp(
            builder: ExtendedNavigator<Router>(
              router: Router(),
              initialRouteArgs:
                  LandingPageArguments(userSnapshot: userSnapshot),
            ),
            theme: trustPingTheme(),
            debugShowCheckedModeBanner: true,
          );
        },
      ),
    );
  }
}

ThemeData trustPingTheme() {
  const MaterialColor tpColors = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );
  return ThemeData(
    fontFamily: 'Inter',
    primarySwatch: tpColors,
    accentColor: Color.fromRGBO(255, 217, 76, 1.0),
    // accentColor: Color.fromRGBO(255, 115, 147, 1.0),
    // accentColor: Color.fromRGBO(76, 108, 184, 1.0),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: const Color.fromRGBO(48, 61, 68, 1.0),
      ),
      headline6: TextStyle(
        fontSize: 18.5,
        fontWeight: FontWeight.w400,
        height: 1.3,
        color: const Color.fromRGBO(48, 61, 68, 1.0),
      ),
      bodyText2: TextStyle(
        fontSize: 15.0,
        height: 1.2,
        color: const Color.fromRGBO(48, 61, 68, 1.0),
      ),
    ),
  );
}

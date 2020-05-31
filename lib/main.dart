import 'package:auto_route/auto_route.dart';
import 'package:trust_ping_app/app/auth_widget_builder.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/theme.dart';

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
            theme: Style.themeData,
            debugShowCheckedModeBanner: true,
          );
        },
      ),
    );
  }
}

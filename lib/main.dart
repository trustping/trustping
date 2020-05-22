import 'package:auto_route/auto_route.dart';
import 'package:trust_ping_app/app/auth_widget_builder.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';

import 'app/home/models/user.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
///   [AuthWidget]
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
        Provider<FirebaseAuthService>(
          create: authServiceBuilder,
        ),
      ],
      child: AuthWidgetBuilder(
        databaseBuilder: databaseBuilder,
        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          return MaterialApp(
            builder: ExtendedNavigator<Router>(
              router: Router(),
              initialRouteArgs: AuthWidgetArguments(userSnapshot: userSnapshot),
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
  return ThemeData(
    fontFamily: 'Inter',
    // primarySwatch: Colors.yellow,
    // accentColor: Colors.redAccent,
  );
}

// ########################################################################################
// MIN EXMAPLE
class MyAppDummy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        print("$snapshot");
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return HomePage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Center(
        child: RaisedButton(
          child: Text('Sign in anonymously'),
          onPressed: _signInAnonymously,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}

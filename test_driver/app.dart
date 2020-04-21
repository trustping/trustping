//import 'package:trust_ping_app/main.dart' as app;
import 'package:mockito/mockito.dart';
import 'package:trust_ping_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:trust_ping_app/services/firestore_database.dart';

import 'fake_auth_service.dart';

class MockDatabase extends Mock implements FirestoreDatabase {}

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(MyApp(
    authServiceBuilder: (_) => FakeAuthService(),
    databaseBuilder: (_, __) => MockDatabase(),
  ));
}

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';

class MockAuthService extends Mock implements FirebaseAuthService {}

class MockDatabase extends Mock implements FirestoreDatabase {}

class MockWidgetsBinding extends Mock implements WidgetsBinding {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

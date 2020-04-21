import 'dart:async';

import 'package:trust_ping_app/app/home/models/user.dart';
import 'package:trust_ping_app/app/sign_in/sign_in_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main() {
  MockAuthService mockAuthService;
  SignInViewModel viewModel;

  setUp(() {
    mockAuthService = MockAuthService();
    viewModel = SignInViewModel(auth: mockAuthService);
  });

  tearDown(() {
    mockAuthService = null;
    viewModel = null;
  });

  void stubSignInAnonymouslyReturnsUser() {
    when(mockAuthService.signInAnonymously())
        .thenAnswer((_) => Future<User>.value(User(uid: '123')));
  }

  void stubSignInAnonymouslyThrows(Exception exception) {
    when(mockAuthService.signInAnonymously()).thenThrow(exception);
  }

  test(
      'WHEN view model signs in anonymously'
      'AND auth returns valid user'
      'THEN isLoading is true', () async {
    stubSignInAnonymouslyReturnsUser();

    await viewModel.signInAnonymously();

    expect(viewModel.isLoading, true);
  });

  test(
      'WHEN view model signs in anonymously'
      'AND auth throws an exception'
      'THEN view model throws an exception'
      'THEN isLoading is false', () async {
    final exception = PlatformException(code: 'ERROR_MISSING_PERMISSIONS');
    stubSignInAnonymouslyThrows(exception);

    expect(() async => await viewModel.signInAnonymously(), throwsA(exception));

    expect(viewModel.isLoading, false);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:trust_ping_app/app/home/models/user_profile.dart';

void main() {
  group('fromMap', () {
    test('with null input data', () {
      final userProfile = UserProfile.fromMap(null, "someFakeDocumentID");
      final expectedUserProfile = UserProfile(
        id: "someFakeDocumentID",
        name: "",
        yearOfBirth: null,
        interests: [],
        circumstances: [],
      );
      expect(userProfile, expectedUserProfile);
    });

    test('with null circumstances', () {
      final userProfile = UserProfile.fromMap(
        {
          "name": "Foo",
          "interests": ["Yoga"],
          "circumstances": null,
        },
        "someFakeDocumentID",
      );
      final expectedUserProfile = UserProfile(
        id: "someFakeDocumentID",
        name: "Foo",
        yearOfBirth: null,
        interests: ["Yoga"],
        circumstances: [],
      );
      expect(userProfile, expectedUserProfile);
    });

    test('with no circumstances', () {
      final userProfile = UserProfile.fromMap(
        {
          "name": "Foo",
          "interests": ["Yoga"],
          // "circumstances": null,
        },
        "someFakeDocumentID",
      );
      final expectedUserProfile = UserProfile(
        id: "someFakeDocumentID",
        name: "Foo",
        yearOfBirth: null,
        interests: ["Yoga"],
        circumstances: [],
      );
      expect(userProfile, expectedUserProfile);
    });

    test('with no interests', () {
      final userProfile = UserProfile.fromMap(
        {
          "name": "Foo",
          // "interests": ["Yoga"],
          "circumstances": ["Kinder"],
        },
        "someFakeDocumentID",
      );
      final expectedUserProfile = UserProfile(
        id: "someFakeDocumentID",
        name: "Foo",
        yearOfBirth: null,
        interests: [],
        circumstances: ["Kinder"],
      );
      expect(userProfile, expectedUserProfile);
    });
  });

  group('toMap', () {
    test('with valid data', () {
      final userProfile = UserProfile(
        id: "someFakeDocumentID",
        name: "Foo",
        yearOfBirth: 1985,
        interests: ["Yoga"],
        circumstances: ["Kinder"],
      );
      expect(
        userProfile.toMap(),
        {
          "name": "Foo",
          "yearOfBirth": 1985,
          "interests": ["Yoga"],
          "circumstances": ["Kinder"]
        },
      );
    });
  });
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trust_ping_app/utils.dart';
part 'user_profile.freezed.dart';

class ProfileChoices {
  static const List<String> interests = [
    "Ernaehrung",
    "Yoga",
    "Sport",
    "Meditation",
    "Nebenwirkungen"
  ];

  static const List<String> circumstances = [
    "Kinder",
    "Berufstaetig",
    "Rentner",
  ];
}

@freezed
abstract class UserProfile implements _$UserProfile {
  const UserProfile._();
  const factory UserProfile({
    String id,
    String name,
    int yearOfBirth,
    List<String> interests,
    List<String> circumstances,
  }) = _UserProfile;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'yearOfBirth': yearOfBirth,
      'interests': interests,
      'circumstances': circumstances,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> data, String documentID) {
    if (data == null) {
      return UserProfile(
        id: documentID,
        name: "",
        yearOfBirth: null,
        interests: [],
        circumstances: [],
      );
    }

    final String _name = data["name"] ?? "";
    final int _yearOfBirth = data["yearOfBirth"];

    final List<String> _interests =
        listify<String>(data.get("interests", null));
    final List<String> _circumstances =
        listify<String>(data.get("circumstances", null));

    final user = UserProfile(
      id: documentID,
      name: _name,
      yearOfBirth: _yearOfBirth,
      interests: _interests,
      circumstances: _circumstances,
    );
    return user;
  }
}

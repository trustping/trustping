import 'package:freezed_annotation/freezed_annotation.dart';
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
          circumstances: []);
    }
    assert(data["interests"] != null);
    assert(data["circumstances"] != null);
    final String _name = data["name"];
    final int _yearOfBirth = data["yearOfBirth"];
    final List<String> _interests = List.from(data["interests"]);
    final List<String> _circumstances = List.from(data["circumstances"]);

    return UserProfile(
      id: documentID,
      name: _name,
      yearOfBirth: _yearOfBirth,
      interests: _interests,
      circumstances: _circumstances,
    );
  }
}

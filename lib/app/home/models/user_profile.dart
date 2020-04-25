import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_profile.freezed.dart';

@freezed
abstract class UserProfile implements _$UserProfile {
  const UserProfile._();
  const factory UserProfile({
    String id,
    String name,
    List<String> interests,
  }) = _UserProfile;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'interests': interests,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> data, String documentID) {
    assert(data["interests"] != null);

    final List<String> _interests = List.from(data["interests"]);
    return UserProfile(
      id: documentID,
      interests: _interests,
    );
  }
}

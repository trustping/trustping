import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
abstract class User implements _$User {
  const User._();
  const factory User({
    String uid,
    String email,
    String photoUrl,
    String displayName,
  }) = _User;
}

import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/models/user_profile.dart';

/// A class representing the initial contact ping to other users.
class PingViewModel {
  final UserProfile userProfile;
  PingViewModel(this.userProfile);

  bool useName = true;
  bool useYearOfBirth = true;
  bool useInterests = true;
  bool useCircumstances = true;

  get nameSentence => 'Mein Name ist *${userProfile.name}*.';
  get yearOfBirthSentence => 'Ich bin Jahrgang *${userProfile.yearOfBirth}*.';
  get interestSentence =>
      'Ich interessiere mich fuer: *${userProfile.interests.join(", ")}*.';
  get circumstancesSentence =>
      'Meine Lebensumstaendge: *${userProfile.circumstances.join(", ")}*.';

  String compose(String customMessage) {
    print('composing...');
    List<String> result = [
      if (useName) nameSentence,
      if (useYearOfBirth) yearOfBirthSentence,
      if (useInterests) interestSentence,
      if (useCircumstances) circumstancesSentence,
      if (customMessage.isNotEmpty) "\n",
      if (customMessage.isNotEmpty) customMessage,
    ];
    String msg = result.join(' ');
    return msg;
  }
}

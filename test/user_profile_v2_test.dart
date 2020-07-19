import 'package:flutter_test/flutter_test.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart';

void main() {
  group('IDs should be unique for', () {
    var optionLists = [
      CANCER_TYPES,
      CANCER_PROPERTIES,
      CANCER_PHASES,
      THERAPY_METHODS,
      THERAPY_SIDE_EFFECTS,
      SITUATION_GENERAL,
      SITUATION_INTERESTS,
    ];
    optionLists.forEach((options) {
      test('$options', () {
        int numUniqueIDs = Set.from(options.map((item) => item.id)).length;
        expect(numUniqueIDs, options.length);
      });
    });
  });
}

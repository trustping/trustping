import 'package:flutter_test/flutter_test.dart';
import 'package:trust_ping_app/utils.dart';

void main() {
  group('listify', () {
    test('with null', () {
      expect(listify(null), []);
    });
    test('with empty list', () {
      expect(listify([]), []);
    });
    test('with string list', () {
      expect(listify(["a", "b"]), ["a", "b"]);
    });
    test('with int list', () {
      expect(listify([1, 2]), [1, 2]);
    });
    test('with string', () {
      expect(listify("foo"), ["foo"]);
    });
    test('with int', () {
      expect(listify(1), [1]);
    });
  });
}

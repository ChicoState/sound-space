library smoke_test;

// dart test framework
import 'package:test/test.dart';

void main() {
  test('Smoke test', () {
    final smoke = 'Smoke';
    expect(smoke, 'Smoke'); // expect is assert that takes agrs>1
  });
}

library valid_url;

// dart test framework
import 'package:test/test.dart';
import '../lib/helpers/url_validator.dart';

void main() {
  group('Valid Url', () {
    test('simple_url', () {
      String? url = 'https://www.youtube.com/watch?v=n61ULEU7CO0';
      expect(true, validateUrl(url));
    });
    test('inc_url', () {
      String? url = 'www.youtube.com/watch?v=n61ULEU7CO0';
      expect(false, validateUrl(url));
    });
    test('no_key', () {
      String? url = 'https://www.youtube.com/watch';
      expect(false, validateUrl(url));
    });
  });
}

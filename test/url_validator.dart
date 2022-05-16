library valid_url;

// dart test framework
import 'package:test/test.dart';
import 'package:soundspace/helpers/url_validator.dart';

void main() {
  group('Valid Url', () {
    test('simple_url', () {
      String? url = 'https://www.youtube.com/watch?v=n61ULEU7CO0';
      expect(true, validateUrl(url));
    });
    test('youtube_url', () {
      String? url = 'https://www.youtube.com/watch?v=7NOSDKb0HlU';
      expect(true, validateUrl(url));
    });
    test('youtube_url_2', () {
      String? url = 'https://www.youtube.com/watch?v=acsLxmnjMho';
      expect(true, validateUrl(url));
    });
    test('youtube_url_3', () {
      String? url = 'https://www.youtube.com/watch?v=lTRiuFIWV54';
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

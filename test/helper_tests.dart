library functions;

// dart test framework
import 'package:test/test.dart';
import '../lib/pages/visuals/url_key_handler.dart';

void main() {
  group('URL_key_finder tests', () {
    test('simple_single_url', () {
      final test_url = 'https://www.youtube.com/watch?v=6Sok3yLzkqo';
      final url_key = '6Sok3yLzkqo';
      expect(url_key, urlKeyFinder([test_url])[0]);
    });
    test('long_list', () {
      final test_list = [
        'https://www.youtube.com/watch?v=_hHwz1UWJmI',
        'https://www.youtube.com/watch?v=nq4tT68UoCg',
        'https://www.youtube.com/watch?v=-YUYLbjl7Sk',
        'https://www.youtube.com/watch?v=X-XZx1o_w-A',
        'https://www.youtube.com/watch?v=8iU8LPEa4o0',
        'https://www.youtube.com/watch?v=n61ULEU7CO0'
      ];
      final url_keys = [
        '_hHwz1UWJmI',
        'nq4tT68UoCg',
        '-YUYLbjl7Sk',
        'X-XZx1o_w-A',
        '8iU8LPEa4o0',
        'n61ULEU7CO0'
      ];
      expect(url_keys, urlKeyFinder(test_list));
    });
    test('indexing_list', () {
      // this test proves that no extra information is extracted
      final test_list = [
        'https://www.youtube.com/watch?v=_hHwz1UWJmI=',
        'https://www.youtube.com/watch?v=nq4tT68UoCg',
        'https://www.youtube.com/watch?v=-YUYLbjl7Sk',
        'https://www.youtube.com/watch?v=X-XZx1o_w-A',
        'https://www.youtube.com/watch?v=8iU8LPEa4o0',
        'https://www.youtube.com/watch?v=n61ULEU7CO0'
      ];
      final url_keys = ['_hHwz1UWJmI'];
      expect(url_keys[0], urlKeyFinder(test_list)[0]);
    });
  });
}

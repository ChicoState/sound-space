library functions;

// dart test framework
import 'package:test/test.dart';
import 'package:soundspace/pages/visuals/url_key_handler.dart';

void main() {
  group('URL_key_finder tests', () {
    test('simple_single_url', () {
      const testUrl = 'https://www.youtube.com/watch?v=6Sok3yLzkqo';
      const urlKey = '6Sok3yLzkqo';
      expect(urlKey, urlKeyFinder([testUrl])[0]);
    });
    test('long_list', () {
      final testList = [
        'https://www.youtube.com/watch?v=_hHwz1UWJmI',
        'https://www.youtube.com/watch?v=nq4tT68UoCg',
        'https://www.youtube.com/watch?v=-YUYLbjl7Sk',
        'https://www.youtube.com/watch?v=X-XZx1o_w-A',
        'https://www.youtube.com/watch?v=8iU8LPEa4o0',
        'https://www.youtube.com/watch?v=n61ULEU7CO0'
      ];
      final urlKeys = [
        '_hHwz1UWJmI',
        'nq4tT68UoCg',
        '-YUYLbjl7Sk',
        'X-XZx1o_w-A',
        '8iU8LPEa4o0',
        'n61ULEU7CO0'
      ];
      expect(urlKeys, urlKeyFinder(testList));
    });
    test('indexing_list', () {
      // this test proves that no extra information is extracted
      final testList = [
        'https://www.youtube.com/watch?v=_hHwz1UWJmI=',
        'https://www.youtube.com/watch?v=nq4tT68UoCg',
        'https://www.youtube.com/watch?v=-YUYLbjl7Sk',
        'https://www.youtube.com/watch?v=X-XZx1o_w-A',
        'https://www.youtube.com/watch?v=8iU8LPEa4o0',
        'https://www.youtube.com/watch?v=n61ULEU7CO0'
      ];
      final urlKeys = ['_hHwz1UWJmI'];
      expect(urlKeys[0], urlKeyFinder(testList)[0]);
    });
    test('indexing_list_middle', () {
      // this test proves that no extra information is extracted
      final testList = [
        'https://www.youtube.com/watch?v=_hHwz1UWJmI=',
        'https://www.youtube.com/watch?v=nq4tT68UoCg',
        'https://www.youtube.com/watch?v=-YUYLbjl7Sk',
        'https://www.youtube.com/watch?v=X-XZx1o_w-A',
        'https://www.youtube.com/watch?v=8iU8LPEa4o0',
        'https://www.youtube.com/watch?v=n61ULEU7CO0'
      ];
      final urlKeys = ['X-XZx1o_w-A'];
      expect(urlKeys[0], urlKeyFinder(testList)[3]);
    });
  });
}

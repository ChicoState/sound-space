library constant;

import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:soundspace/constants/music_list.dart';
import 'package:soundspace/constants/style.dart';

void main() {
  group('constants tests', () {
    test('first object', () {
      expect(musicList[0]['title'], 'Heat Waves');
      expect(musicList[0]['singer'], 'Glass Animals');
      expect(musicList[0]['url'], 'N/A');
      expect(musicList[0]['coverUrl'],
          'https://upload.wikimedia.org/wikipedia/en/b/b0/Glass_Animals_-_Heat_Waves.png');
    });
    test('second object', () {
      expect(musicList[1]['title'], 'abcdefu');
      expect(musicList[1]['singer'], 'GAYLE');
      expect(musicList[1]['url'], 'N/A');
      expect(musicList[1]['coverUrl'],
          'https://upload.wikimedia.org/wikipedia/en/f/f0/Gayle_-_ABCDEFU.png');
    });
    test('third object', () {
      expect(musicList[2]['title'], 'Easy On Me');
      expect(musicList[2]['singer'], 'Adele');
      expect(musicList[2]['url'], 'N/A');
      expect(musicList[2]['coverUrl'],
          'https://upload.wikimedia.org/wikipedia/en/7/76/Adele_-_30.png');
    });
    test('forth object', () {
      expect(musicList[3]['title'], 'Stay');
      expect(musicList[3]['singer'], 'The Kid LAROI & Justin Bieber');
      expect(musicList[3]['url'], 'N/A');
      expect(musicList[3]['coverUrl'],
          'https://upload.wikimedia.org/wikipedia/en/thumb/0/0c/The_Kid_Laroi_and_Justin_Bieber_-_Stay.png/220px-The_Kid_Laroi_and_Justin_Bieber_-_Stay.png');
    });
  });
  group('colors', () {
    test('light', () {
      expect(light, Color(0xFFF7F8FC));
    });
    test('lightGrey', () {
      expect(lightGrey, Color(0xFFA4A6B3));
    });
    test('dark', () {
      expect(dark, Color(0xFF363740));
    });
  });
}

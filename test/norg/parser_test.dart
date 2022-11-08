import 'package:charcode/charcode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groen/norg/parser.dart';
import 'package:groen/norg/tokenizer.dart';
import 'package:groen/string_helpers.dart';

void main() {
  test('should parse word token from simple character tokens', () {
    // given
    final simpleTokens = [
      SimpleToken.fromChar($H),
      SimpleToken.fromChar($e),
      SimpleToken.fromChar($l),
      SimpleToken.fromChar($l),
      SimpleToken.fromChar($o),
    ];
    final expected = [
      const Token(Range(0, 5), Word('Hello')),
    ];
    // when
    final actual = parse(simpleTokens);
    // then
    expect(actual.first.range, equals(expected.first.range));
    expect(actual.first.data, equals(expected.first.data));
  });

  test('should parse word token from single simple character token', () {
    // given
    final simpleTokens = [
      SimpleToken.fromChar($H),
    ];
    final expected = [
      const Token(Range(0, 1), Word('H')),
    ];
    // when
    final actual = parse(simpleTokens).toList();
    // then
    expect(actual, equals(expected));
  });

  test('should return empty iterable from empty token iterable', () {
    // given
    // when
    final actual = parse(const Iterable.empty()).toList();
    // then
    expect(actual.toList().isEmpty, isTrue);
  });

  test('should parse a space token from multiple simple space token', () {
    // given
    final simpleTokens = [
      SimpleToken.fromChar($space),
      SimpleToken.fromChar($tab),
      SimpleToken.fromChar($space),
      SimpleToken.fromChar($tab),
    ];
    final expected = [
      const Token(Range(0, 4), Space()),
    ];
    // when
    final actual = parse(simpleTokens).toList();
    // then
    expect(actual, equals(expected));
  });

  test('should parse a space token from single simple space token', () {
    // given
    final simpleTokens = [
      SimpleToken.fromChar($space),
    ];
    final expected = [
      const Token(Range(0, 1), Space()),
    ];
    // when
    final actual = parse(simpleTokens).toList();
    // then
    expect(actual, equals(expected));
  });

  test('should parse a soft break from single simple newline token', () {
    // given
    final simpleTokens = [
      SimpleToken.fromChar($lf),
    ];
    final expected = [
      const Token(Range(0, 1), SoftBreak()),
    ];
    // when
    final actual = parse(simpleTokens).toList();
    // then
    expect(actual, equals(expected));
  });

  test('should parse a paragraph break from double simple newline token', () {
    // given
    final simpleTokens = [
      SimpleToken.fromChar($lf),
      SimpleToken.fromChar($lf),
    ];
    final expected = [
      const Token(Range(0, 2), ParagraphBreak()),
    ];
    // when
    final actual = parse(simpleTokens).toList();
    // then
    expect(actual, equals(expected));
  });

  test('should parse attached modifier token types from simple special tokens',
      () {
    // given
    final simpleTokens = [
      SimpleToken.fromChar($c),
      SimpleToken.fromChar($b),
      SimpleToken.fromChar($asterisk),
      SimpleToken.fromChar($b),
      SimpleToken.fromChar($o),
      SimpleToken.fromChar($l),
      SimpleToken.fromChar($d),
      SimpleToken.fromChar($asterisk),
      SimpleToken.fromChar($space),
    ];
    final expected = [
    ];
    // when
    final actual = parse(simpleTokens).toList();
    // then
    expect(actual, equals(expected));
  });

  test('should parse mixed token types from multiple simple tokens', () {
    // given
    final simpleTokens = [
      SimpleToken.fromChar($c),
      SimpleToken.fromChar($n),
      SimpleToken.fromChar($lf),
      SimpleToken.fromChar($r),
      SimpleToken.fromChar($space),
      SimpleToken.fromChar($lf),
      SimpleToken.fromChar($lf),
      SimpleToken.fromChar($h),
    ];
    final expected = [
      const Token(Range(0, 2), Word('cn')),
      const Token(Range(2, 3), SoftBreak()),
      const Token(Range(3, 4), Word('r')),
      const Token(Range(4, 5), Space()),
      const Token(Range(5, 7), ParagraphBreak()),
      const Token(Range(7, 8), Word('h')),
    ];
    // when
    final actual = parse(simpleTokens).toList();
    // then
    expect(actual, equals(expected));
  });
}

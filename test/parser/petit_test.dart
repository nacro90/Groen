import 'package:flutter_test/flutter_test.dart';
import 'package:groen/parser/petit.dart';
import 'package:petitparser/petitparser.dart';

extension AssertiveParse on Parser {
  Result parse(String input) {
    final result = parse(input);
    if (result.isFailure) {
      fail(result.message);
    }
    return result;
  }
}

void main() {
  test('should parse plain word', () {
    // given
    final definition = NorgGrammar();
    final parser = definition.build();
    // when
    final success = parser.parse('word');
    // then
    expect(success.value[0], 'word');
  });

  test('should parse bold', () {
    // given
    final definition = NorgGrammar();
    final parser = definition.build();
    // when
    final success = parser.parse('*word*');
    // then
    final actual = success.value;
    final first = actual[0];
    expect(first[0], '*');
    expect(first[1], 'word');
    expect(first[2], '*');
  });

  test('should parse plain and italic divided with a space', () {
    // given
    final definition = NorgGrammar();
    final parser = definition.build();
    // when
    final result = parser.parse('osman /word/');
    // then
    final actual = result.value;
    expect(actual[0], 'osman');
    expect(actual[1], ' ');
    final italic = actual[2];
    expect(italic[0], '/');
    expect(italic[1], 'word');
    expect(italic[2], '/');
  });
}

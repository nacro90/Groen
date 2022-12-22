import 'package:flutter_test/flutter_test.dart';
import 'package:groen/parser/petit.dart';
import 'package:petitparser/petitparser.dart';

void expectResult(
  Result result,
  dynamic matcher, [
  String? reason,
  bool skip = false,
]) {
  if (result.isFailure) {
    fail(result.message);
  }
  expect(result.value, matcher, reason: reason, skip: skip);
}

void main() {
  test('should parse plain word', () {
    // given
    final definition = NorgDefinition();
    final parser = definition.build();
    // when
    final result = parser.parse('word');
    // then
    if (result.isFailure) {
      fail(result.message);
    }
    if (result.value is! Sequence2) {
      fail('type mismatch: ${result.runtimeType} != Sequence2');
    }
    final actual = result.value as Sequence2;
    expect(actual.first, ['word']);
    expect(actual.second, null);
  });

  test('should parse words with whitespaces', () {
    // given
    final definition = NorgDefinition();
    final parser = definition.build();
    // when
    final actual = parser.parse('word1 \t word2');
    // then
    expectResult(actual, ['word1', ' \t ', 'word2']);
  });

  test('should parse words with spaces and punctuations', () {
    // given
    final definition = NorgDefinition();
    final parser = definition.build();
    // when
    final actual = parser.parse('word1, word2!');
    // then
    expectResult(actual, ['word1', ',', ' ', 'word2', '!']);
  });

  test('should parse words with escape', () {
    // given
    final definition = NorgDefinition();
    final parser = definition.build();
    // when
    final actual = parser.parse(r'word1\ word2!');
    // then
    expectResult(actual, ['word1', r'\', ' ', 'word2', '!']);
  });
}

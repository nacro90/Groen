import 'package:charcode/charcode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groen/parser/tokenizer.dart';

void main() {
  test('isValid() returns true when input string is bold text', () {
    // given
    const input = "\tHello_{World}";
    final expected = [
      SimpleToken.fromChar($tab),
      SimpleToken.fromChar($H),
      SimpleToken.fromChar($e),
      SimpleToken.fromChar($l),
      SimpleToken.fromChar($l),
      SimpleToken.fromChar($o),
      SimpleToken.fromChar($_),
      SimpleToken.fromChar($openBrace),
      SimpleToken.fromChar($W),
      SimpleToken.fromChar($o),
      SimpleToken.fromChar($r),
      SimpleToken.fromChar($l),
      SimpleToken.fromChar($d),
      SimpleToken.fromChar($closeBrace),
    ];
    // when
    final actual = tokenize(input.runes).toList();
    // then
    expect(actual, equals(expected));
  });
}

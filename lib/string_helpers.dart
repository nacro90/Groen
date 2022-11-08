import 'package:charcode/charcode.dart';

extension NullOrEmpty on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;
}

extension CodeUnit on String {
  int get codeUnit {
    if (codeUnits.length > 1) {
      FormatException("The string ${this} has more code units than 1");
    }
    return codeUnitAt(0);
  }
}

const punctuations = {
  $exclamation,
  $doubleQuote,
  $hash,
  $dollar,
  $percent,
  $ampersand,
  $singleQuote,
  $openParen,
  $closeParen,
  $asterisk,
  $plus,
  $comma,
  $dash,
  $dot,
  $slash,
  $colon,
  $semicolon,
  $question,
  $at,
  $backslash,
  $openBracket,
  $closeBracket,
  $circumflex,
  $underscore,
  $grave,
  $openBrace,
  $pipe,
  $closeBrace,
  $tilde,
};

bool isPunctuation(int char) {
  return punctuations.contains(char);
}

import 'package:charcode/charcode.dart';
import 'package:equatable/equatable.dart';

enum SimpleTokenType {
  character,
  space,
  newline,
  special,
  linkOpen,
  linkClose,
}

const charTokenMap = {
  $tab: SimpleTokenType.space,
  $space: SimpleTokenType.space,
  $lf: SimpleTokenType.newline,
  $asterisk: SimpleTokenType.special,
  $slash: SimpleTokenType.special,
  $underscore: SimpleTokenType.special,
  $circumflex: SimpleTokenType.special,
  $comma: SimpleTokenType.special,
  $dash: SimpleTokenType.special,
  $percent: SimpleTokenType.special,
  $exclamation: SimpleTokenType.special,
  $openBrace: SimpleTokenType.linkOpen,
  $closeBrace: SimpleTokenType.linkClose,
};

class SimpleToken extends Equatable {
  final SimpleTokenType type;
  final int char;

  const SimpleToken(this.type, this.char);

  SimpleToken.fromString(String str) : this.fromChar(str.codeUnitAt(0));

  SimpleToken.fromChar(this.char) : type = _getType(char);

  @override
  List<Object> get props => [type, char];

  @override
  bool get stringify => true;
}

Iterable<SimpleToken> tokenize(Iterable<int> chars) {
  return chars.map(_tokenizeChar);
}

SimpleToken _tokenizeChar(int char) {
  return SimpleToken(_getType(char), char);
}

SimpleTokenType _getType(int char) {
  return charTokenMap[char] ?? SimpleTokenType.character;
}

import 'package:groen/parser/chardef.dart';
import 'package:petitparser/petitparser.dart';

CharacterParser charCode(int code, [String? message]) {
  return CharacterParser(
    SingleCharPredicate(code),
    '"${message ?? String.fromCharCode(code)}" expected',
  );
}

extension SurroundedParserExtension on Parser {
  Parser<Sequence3> surroundedBy(Parser left, [Parser? right]) =>
      seq3(left, this, right ?? left);
}

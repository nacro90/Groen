import 'package:petitparser/petitparser.dart';

Parser<String> charCode(int code, [String? message]) {
  return CharacterParser(
    SingleCharPredicate(code),
    '"${message ?? String.fromCharCode(code)}" expected',
  );
}

extension SurroundedParserExtension<T> on Parser<T> {
  Parser surroundedBy(Parser s) => s & this & s;
}

extension StarSeparatedList on Parser {
  Parser<List> starSeparatedList(Parser p, {growable = false}) =>
      starSeparated(p).map((s) => s.sequential.toList(growable: growable));
}

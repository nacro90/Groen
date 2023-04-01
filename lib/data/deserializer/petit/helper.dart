import 'package:petitparser/petitparser.dart';

Parser<String> charCode(int code, [String? message]) {
  return CharacterParser(
    SingleCharPredicate(code),
    '"${message ?? String.fromCharCode(code)}" expected',
  );
}

extension SurroundedParserExtension on Parser {
  Parser<Sequence3> surroundedBy(Parser left, [Parser? right]) =>
      seq3(left, this, right ?? left);
}

extension StarSeparatedList on Parser {
  Parser<List> starSeparatedList(Parser p, {growable = false}) =>
      starSeparated(p).map((s) => s.sequential.toList(growable: growable));
}

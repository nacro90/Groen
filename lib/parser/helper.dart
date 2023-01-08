import 'package:groen/parser/chardef.dart';
import 'package:petitparser/petitparser.dart';

CharacterParser charCode(int code, [String? message]) {
  return CharacterParser(
    SingleCharPredicate(code),
    '"${message ?? String.fromCharCode(code)}" expected',
  );
}

final punctuationParser = punctuations.map(charCode).toChoiceParser();

final whitespaceParser = whitespaces.map(charCode).toChoiceParser();

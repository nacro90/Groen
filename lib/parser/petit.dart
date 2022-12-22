import 'package:charcode/charcode.dart';
import 'package:groen/parser/char_definitions.dart';
import 'package:petitparser/petitparser.dart';

final _punctuationParser = punctuations.map(_charCode).toChoiceParser(
      failureJoiner: (_, __) => const Failure('', 0, 'Punctuation expected'),
    );
final _whitespaceParser = whitespaces.map(_charCode).toChoiceParser(
      failureJoiner: (_, __) => const Failure('', 0, 'Whitespace expected'),
    );

class NorgDefinition extends GrammarDefinition {
  @override
  Parser start() => ref0(document).end();

  Parser document() => ref0(paragraphSegment);

  // Parser document() => ref0(content).optional() & ref0(section).star();

  Parser paragraphSegment() =>
      (ref0(word) | ref0(whitespace) | ref0(punctuation)).plus();

  Parser<String> word() => (letter() | digit()).plus().flatten();

  Parser<String> whitespace() => _whitespaceParser.plus().flatten();

  Parser<String> punctuation() => _punctuationParser;

  Parser escaping() => _charCode($backslash);

  Parser alphanum() => letter() | digit();

  Parser attachedModifierBody() => ref0(alphanum);

  Parser attachedModifier(int c) =>
      seq3(_charCode(c), ref0(attachedModifierBody), _charCode(c));

  Parser bold() => ref1(attachedModifier, $asterisk);
  Parser italic() => ref1(attachedModifier, $slash);
  Parser underline() => ref1(attachedModifier, $underscore);
  Parser strikethrough() => ref1(attachedModifier, $dash);
  Parser spoiler() => ref1(attachedModifier, $exclamation);
  Parser superscript() => ref1(attachedModifier, $circumflex);
  Parser subscript() => ref1(attachedModifier, $comma);
  Parser inlineCode() => ref1(attachedModifier, $grave);
  Parser inlineComment() => ref1(attachedModifier, $percent);
  Parser inlineMath() => ref1(attachedModifier, $dollar);
  Parser variable() => ref1(attachedModifier, $ampersand);

  Parser lineEnding() => lineEndings
      .map(_charCode)
      .cast<Parser>()
      .followedBy([seq2(_charCode($cr), _charCode($lf))]).toChoiceParser();

  Parser regularChar() => [
        ref0(whitespace),
        // ref0(lineEnding),
        ref0(punctuation),
        ref0(escaping),
      ].toChoiceParser().not();
}

CharacterParser _charCode(int code, [String? message]) {
  return CharacterParser(
    SingleCharPredicate(code),
    '"${message ?? String.fromCharCode(code)}" expected',
  );
}

import 'package:charcode/charcode.dart';
import 'package:groen/parser/chardef.dart';
import 'package:groen/parser/helper.dart';
import 'package:groen/parser/model.dart';
import 'package:petitparser/petitparser.dart';

class NorgGrammar extends GrammarDefinition {
  @override
  Parser start() => ref0(document).end();

  Parser document() => ref0(content).plus();

  Parser content() =>
      ref0(word) | ref0(attachedModified) | ref0(whitespace).plus().flatten();

  Parser alphanum() => letter() | digit();

  Parser word() => ref0(alphanum).plus().flatten();

  Parser whitespace() => whitespaceParser.plus().flatten();

  Parser punctuation() => punctuationParser;

  Parser attachedModifierBody() => ref0(alphanum);

  Parser attachedModified() =>
      ref0(bold) |
      ref0(italic) |
      ref0(underline) |
      ref0(strikethrough) |
      ref0(spoiler) |
      ref0(superscript) |
      ref0(subscript) |
      ref0(inlineCode) |
      ref0(inlineComment) |
      ref0(inlineMath) |
      ref0(variable);

  Parser bold() => charCode($asterisk) & ref0(word) & charCode($asterisk);
  Parser italic() => charCode($slash) & ref0(word) & charCode($slash);
  Parser underline() =>
      charCode($underscore) & ref0(word) & charCode($underscore);
  Parser strikethrough() => charCode($dash) & ref0(word) & charCode($dash);
  Parser spoiler() =>
      charCode($exclamation) & ref0(word) & charCode($exclamation);
  Parser superscript() =>
      charCode($circumflex) & ref0(word) & charCode($circumflex);
  Parser subscript() => charCode($comma) & ref0(word) & charCode($comma);
  Parser inlineCode() => charCode($grave) & ref0(word) & charCode($grave);
  Parser inlineComment() =>
      charCode($percent) & ref0(word) & charCode($percent);
  Parser inlineMath() => charCode($dollar) & ref0(word) & charCode($dollar);
  Parser variable() => charCode($ampersand) & ref0(word) & charCode($ampersand);

  // Parser lineEnding() => lineEndings
  //     .map(_charCode)
  //     .cast<Parser>()
  //     .followedBy([seq2(_charCode($cr), _charCode($lf))]).toChoiceParser();

  // Parser regularChar() => [
  //       ref0(whitespace),
  //       // ref0(lineEnding),
  //       ref0(punctuation),
  //       ref0(escaping),
  //     ].toChoiceParser().not();
}

class NorgParser extends NorgGrammar {
  @override
  Parser start() => super.start().map((items) => NorgDocument(items[0]));

  @override
  Parser content() => super.document().map((items) => NorgContent(items[0]));

  @override
  Parser bold() => super.bold().map((items) => NorgBold(items[1]));
}

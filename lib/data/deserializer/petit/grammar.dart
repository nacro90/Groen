import 'package:groen/data/chardef.dart';
import 'package:petitparser/petitparser.dart';

import 'helper.dart';

class NorgGrammar extends GrammarDefinition {
  @override
  Parser start() => ref0(document).end();

  Parser document() => ref0(paragraph).starSeparatedList(ref0(paragraphBreak));

  Parser paragraph() =>
      ref0(paragraphSegment).starSeparatedList(ref0(lineEnding));

  Parser paragraphSegment() => [
        ref0(link),
        ref0(escaping),
        ref0(attachedModifiedElement),
        ref0(norgWhitespace),
        ref0(plainText),
      ].toChoiceParser().plus();

  Parser plainText() => whitespace().neg().plus().flatten('plaintext');

  Parser link() => [
        ref0(url),
      ].toChoiceParser();

  Parser url() => (char('{') &
      seq2(
        newline().not(),
        [
          ref0(paragraphBreak),
          seq2(newline(), char('}')),
          char('}'),
        ].toChoiceParser().neg().plus(),
      ).flatten('location') &
      char('}'));

  Parser attachedModifierContent(String c) => [
        whitespace().not(),
        [
          ref0(paragraphBreak),
          (whitespace() & char(c)),
          char(c),
        ].toChoiceParser().neg().plus(),
      ].toSequenceParser().flatten('content');

  Parser attachedModified(String c) =>
      char(c) & ref1(attachedModifierContent, c) & char(c);
  Parser bold() => ref1(attachedModified, '*');
  Parser italic() => ref1(attachedModified, '/');
  Parser underline() => ref1(attachedModified, '_');
  Parser strikethrough() => ref1(attachedModified, '-');
  Parser spoiler() => ref1(attachedModified, '!');
  Parser superscript() => ref1(attachedModified, '^');
  Parser subscript() => ref1(attachedModified, ',');
  Parser inlineCode() => ref1(attachedModified, '`');
  Parser inlineComment() => ref1(attachedModified, '%');
  Parser attachedModifiedElement() => [
        ref0(bold),
        ref0(italic),
        ref0(underline),
        ref0(strikethrough),
        ref0(spoiler),
        ref0(superscript),
        ref0(subscript),
        ref0(inlineCode),
        ref0(inlineComment),
      ].toChoiceParser();

  Parser escaping() => char('\\') & any();

  Parser lineEnding() => newline();

  Parser paragraphBreak() =>
      newline().repeatSeparated(ref0(norgWhitespace).star(), 2, unbounded);

  Parser norgWhitespace() => whitespaces
      .map(charCode)
      .toChoiceParser(failureJoiner: selectLast)
      .plus()
      .flatten('whitespace');
}

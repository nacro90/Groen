import 'package:charcode/charcode.dart';
import 'package:groen/data/chardef.dart';
import 'package:petitparser/petitparser.dart';

import 'helper.dart';

class NorgGrammar extends GrammarDefinition {
  @override
  Parser start() => ref0(document).end();

  Parser document() => ref0(paragraph).starSeparated(newline().repeat(2));

  Parser paragraph() => (ref0(paragraphSegment) | newline().optional());

  Parser paragraphSegment() => [
        ref0(escaping),
        ref0(attachedModified),
        ref0(nonLineEndingWhitespace).plus().flatten('whitespace'),
        newline().neg().plus().flatten('any'),
      ].toChoiceParser().plus();

  Parser link() => [
        ref0(url),
      ].toChoiceParser();

  Parser url() => seq3(
        char('{'),
        seq2(
          newline().not(),
          [
            newline().repeat(2),
            seq2(newline(), char('}')),
            char('}'),
          ].toChoiceParser().neg().plus(),
        ),
        char('}'),
      );

  Parser<Sequence3> attachedModifiedText(String c) => seq3(
        char(c),
        seq2(
          whitespace().not(),
          [
            newline().repeat(2),
            (whitespace() & char(c)),
            char(c),
          ].toChoiceParser().neg().plus(),
        ),
        char(c),
      );
  Parser bold() => ref1(attachedModifiedText, '*');
  Parser italic() => ref1(attachedModifiedText, '/');
  Parser underline() => ref1(attachedModifiedText, '_');
  Parser strikethrough() => ref1(attachedModifiedText, '-');
  Parser spoiler() => ref1(attachedModifiedText, '!');
  Parser superscript() => ref1(attachedModifiedText, '^');
  Parser subscript() => ref1(attachedModifiedText, ',');
  Parser inlineCode() => ref1(attachedModifiedText, '`');
  Parser inlineComment() => ref1(attachedModifiedText, '%');
  Parser attachedModified() => [
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

  Parser<Sequence2> escaping() => seq2(char(r'\'), any());

  Parser nonWhite() => whitespace().neg();

  Parser paragraphBreak() => string('\n\n');

  Parser nonLineEndingWhitespace() =>
      whitespaces.map(charCode).toChoiceParser(failureJoiner: selectLast);

  // Parser alphanum() => letter() | digit();

  // Parser word() => ref0(alphanum).plus().flatten();

  // Parser punctuation() =>
  //     punctuations.map(charCode).toChoiceParser().flatten("punctuation");

  // Parser regularChar() => [
  //       ref0(whitespace),
  //       // ref0(lineEnding),
  //       ref0(punctuation),
  //       ref0(escaping),
  //     ].toChoiceParser().not();
}

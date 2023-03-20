import 'package:charcode/charcode.dart';
import 'package:groen/core/chardef.dart';
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
        charCode($openBrace),
        seq2(
          newline().not(),
          [
            newline().repeat(2),
            seq2(newline(), charCode($closeBrace)),
            charCode($closeBrace),
          ].toChoiceParser().neg().plus(),
        ),
        charCode($closeBrace),
      );

  Parser<Sequence3> attachedModifiedText(int code) => seq3(
        charCode(code),
        seq2(
          whitespace().not(),
          [
            newline().repeat(2),
            (whitespace() & charCode(code)),
            charCode(code),
          ].toChoiceParser().neg().plus(),
        ),
        charCode(code),
      );
  Parser bold() => ref1(attachedModifiedText, $asterisk);
  Parser italic() => ref1(attachedModifiedText, $slash);
  Parser underline() => ref1(attachedModifiedText, $underscore);
  Parser strikethrough() => ref1(attachedModifiedText, $dash);
  Parser spoiler() => ref1(attachedModifiedText, $exclamation);
  Parser superscript() => ref1(attachedModifiedText, $circumflex);
  Parser subscript() => ref1(attachedModifiedText, $comma);
  Parser inlineCode() => ref1(attachedModifiedText, $grave);
  Parser inlineComment() => ref1(attachedModifiedText, $percent);
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

  Parser<Sequence2> escaping() => seq2(charCode($backslash), any());

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

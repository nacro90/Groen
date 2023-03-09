import 'package:charcode/charcode.dart';
import 'package:groen/parser/helper.dart';
import 'package:petitparser/petitparser.dart';

class NorgGrammar extends GrammarDefinition {
  @override
  Parser start() => ref0(document).end();

  Parser document() => ref0(paragraph).plus();

  Parser paragraph() => ref0(paragraphSegment).plus();

  Parser paragraphSegment() =>
      [
        ref0(attachedModified),
        whitespace().plus().flatten("whitespace"),
        word().plus().flatten('word'),
      ].toChoiceParser().plusLazy(newline()) &
      newline();

  Parser link() => [
        url(),
      ].toChoiceParser();

  Parser url() => char("{") & char("}").neg().plus() & char("}");

  Parser<Sequence3> attachedModifiedText(int code) => seq3(
        charCode(code),
        (whitespace().not() & charCode(code).neg().plus()).flatten(),
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

  Parser attachedModified() =>
      ref0(bold) |
      ref0(italic) |
      ref0(underline) |
      ref0(strikethrough) |
      ref0(spoiler) |
      ref0(superscript) |
      ref0(subscript) |
      ref0(inlineCode) |
      ref0(inlineComment);

  Parser lineEnding() => newline();

  // Parser alphanum() => letter() | digit();

  // Parser word() => ref0(alphanum).plus().flatten();

  // Parser punctuation() => punctuations.map(charCode).toChoiceParser();

  // Parser regularChar() => [
  //       ref0(whitespace),
  //       // ref0(lineEnding),
  //       ref0(punctuation),
  //       ref0(escaping),
  //     ].toChoiceParser().not();
}

class NorgParser extends NorgGrammar {
  // @override
  // Parser start() => super.start().map((items) => NorgDocument(items[0]));

  // @override
  // Parser bold() => super.bold().map((items) => NorgBold(items[1]));
}

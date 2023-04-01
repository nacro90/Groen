import 'package:groen/data/deserializer/petit/model.dart';
import 'package:groen/data/model/model.dart';
import 'package:petitparser/petitparser.dart';

import 'grammar.dart';

extension TokenNodeListCast on Token {
  List<Node> get nodes => (value as List<dynamic>).cast();
}

class NorgParser extends NorgGrammar {
  @override
  Parser document() => super.document().token().map(
        (token) {
          return Document(
            nodes: token.nodes,
            start: token.start,
            line: token.line,
            column: token.column,
            raw: token.input,
          );
        },
      );

  @override
  Parser paragraph() => super.paragraph().token().map(
        (token) => Paragraph(
          nodes: token.nodes,
          start: token.start,
          line: token.line,
          column: token.column,
          raw: token.input,
        ),
      );

  @override
  Parser paragraphSegment() => super.paragraphSegment().token().map(
        (token) {
          return ParagraphSegment(
            nodes: token.nodes,
            start: token.start,
            line: token.line,
            column: token.column,
            raw: token.input,
          );
        },
      );

  @override
  Parser attachedModified(String c) => super.attachedModified(c).token().map(
        (token) => AttachedModified(
          mod: attachedModByChar[token.value[0]]!,
          text: token.value[1],
          start: token.start,
          line: token.line,
          column: token.column,
          raw: token.input,
        ),
      );

  @override
  Parser url() => super.url().token().map(
        (token) => Url(
          location: token.value[1],
          start: token.start,
          line: token.line,
          column: token.column,
          raw: token.input,
        ),
      );

  @override
  Parser escaping() => super.escaping().token().map(
        (token) => Escaping(
          escaped: token.value[1],
          start: token.start,
          line: token.line,
          column: token.column,
          raw: token.input,
        ),
      );

  @override
  Parser norgWhitespace() => super.norgWhitespace().token().map(
        (token) => Whitespace(
          start: token.start,
          line: token.line,
          column: token.column,
          raw: token.input,
        ),
      );

  @override
  Parser plainText() {
    return super.plainText().token().map(
          (token) => PlainText(
              start: token.start,
              line: token.line,
              column: token.column,
              raw: token.input),
        );
  }

  @override
  Parser lineEnding() => super.lineEnding().token().map(
        (token) => LineEnding(
          start: token.start,
          line: token.line,
          column: token.column,
          raw: token.input,
        ),
      );

  @override
  Parser paragraphBreak() => super.paragraphBreak().token().map(
        (token) => ParagraphBreak(
          start: token.start,
          line: token.line,
          column: token.column,
          raw: token.input,
        ),
      );
}

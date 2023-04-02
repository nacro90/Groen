import 'package:flutter_test/flutter_test.dart';
import 'package:groen/data/deserializer/petit/parser.dart';
import 'package:groen/data/model/model.dart';
import 'package:petitparser/debug.dart';
import 'package:petitparser/petitparser.dart';

bool Function(String) parsedAs(
  Parser parser,
  Node node, {
  bool tracing = false,
}) {
  parser = tracing ? trace(parser) : parser;
  return (input) => parser.parse(input).value == node;
}

void expectParse(Parser parser, String parsee, dynamic matcher) =>
    expect(parser.parse(parsee).value, matcher);

void main() {
  group('NorgParser', () {
    late NorgParser np;
    setUp(() {
      np = const NorgParser();
    });
    group('parser', () {
      test('following leading whitespace', () {
        final parser = np.build();
        expectParse(
          parser,
          'test\n',
          const Document(
            start: 0,
            line: 1,
            column: 1,
            raw: 'test\n',
            children: [
              Paragraph(
                start: 0,
                line: 1,
                column: 1,
                raw: 'test',
                children: [
                  ParagraphSegment(
                    start: 0,
                    line: 1,
                    column: 1,
                    raw: 'test',
                    children: [
                      PlainText(start: 0, line: 1, column: 1, raw: 'test'),
                    ],
                  )
                ],
              ),
              LineEnding(start: 4, line: 1, column: 5, raw: '\n'),
            ],
          ),
        );
      });
    });
    test('document', () {
      final parser = np.build();
      expectParse(
        parser,
        '*bold*\t{url} \\/nonitalic/\n\nnewpara',
        const Document(
          start: 0,
          line: 1,
          column: 1,
          raw: '*bold*\t{url} \\/nonitalic/\n\nnewpara',
          children: [
            Paragraph(
              start: 0,
              line: 1,
              column: 1,
              raw: '*bold*\t{url} \\/nonitalic/',
              children: [
                ParagraphSegment(
                  start: 0,
                  line: 1,
                  column: 1,
                  raw: '*bold*\t{url} \\/nonitalic/',
                  children: [
                    AttachedModified(
                        type: AttachedModType.bold,
                        text: 'bold',
                        start: 0,
                        line: 1,
                        column: 1,
                        raw: '*bold*'),
                    Whitespace(start: 6, line: 1, column: 7, raw: '\t'),
                    Url(
                        location: 'url',
                        start: 7,
                        line: 1,
                        column: 8,
                        raw: '{url}'),
                    Whitespace(start: 12, line: 1, column: 13, raw: ' '),
                    Escaping(
                        escaped: '/',
                        start: 13,
                        line: 1,
                        column: 14,
                        raw: '\\/'),
                    PlainText(
                        start: 15, line: 1, column: 16, raw: 'nonitalic/'),
                  ],
                ),
              ],
            ),
            ParagraphBreak(start: 25, line: 1, column: 26, raw: '\n\n'),
            Paragraph(
              start: 27,
              line: 3,
              column: 1,
              raw: "newpara",
              children: [
                ParagraphSegment(
                  start: 27,
                  line: 3,
                  column: 1,
                  raw: "newpara",
                  children: [
                    PlainText(start: 27, line: 3, column: 1, raw: 'newpara'),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
    test('paragraph', () {
      final parser = np.build(start: np.paragraph).end();
      expectParse(
        parser,
        '*bold*\t{url} \\/nonitalic/\nnewline',
        const Paragraph(
          start: 0,
          line: 1,
          column: 1,
          raw: '*bold*\t{url} \\/nonitalic/\nnewline',
          children: [
            ParagraphSegment(
              start: 0,
              line: 1,
              column: 1,
              raw: '*bold*\t{url} \\/nonitalic/',
              children: [
                AttachedModified(
                    type: AttachedModType.bold,
                    text: 'bold',
                    start: 0,
                    line: 1,
                    column: 1,
                    raw: '*bold*'),
                Whitespace(start: 6, line: 1, column: 7, raw: '\t'),
                Url(
                    location: 'url',
                    start: 7,
                    line: 1,
                    column: 8,
                    raw: '{url}'),
                Whitespace(start: 12, line: 1, column: 13, raw: ' '),
                Escaping(
                    escaped: '/', start: 13, line: 1, column: 14, raw: '\\/'),
                PlainText(start: 15, line: 1, column: 16, raw: 'nonitalic/'),
              ],
            ),
            LineEnding(start: 25, line: 1, column: 26, raw: '\n'),
            ParagraphSegment(
              start: 26,
              line: 2,
              column: 1,
              raw: "newline",
              children: [
                PlainText(start: 26, line: 2, column: 1, raw: 'newline'),
              ],
            )
          ],
        ),
      );
    });

    test('paragraph segment', () {
      final parser = np.build(start: np.paragraphSegment).end();
      expectParse(
        parser,
        '*bold*\t{url} \\/nonitalic/',
        const ParagraphSegment(
          start: 0,
          line: 1,
          column: 1,
          raw: '*bold*\t{url} \\/nonitalic/',
          children: [
            AttachedModified(
                type: AttachedModType.bold,
                text: 'bold',
                start: 0,
                line: 1,
                column: 1,
                raw: '*bold*'),
            Whitespace(start: 6, line: 1, column: 7, raw: '\t'),
            Url(location: 'url', start: 7, line: 1, column: 8, raw: '{url}'),
            Whitespace(start: 12, line: 1, column: 13, raw: ' '),
            Escaping(escaped: '/', start: 13, line: 1, column: 14, raw: '\\/'),
            PlainText(start: 15, line: 1, column: 16, raw: 'nonitalic/'),
          ],
        ),
      );
    });

    test('attached modifier', () {
      final parser = np.build(start: np.attachedModifiedElement).end();
      expectParse(
        parser,
        '*bold*',
        const AttachedModified(
          type: AttachedModType.bold,
          text: 'bold',
          start: 0,
          line: 1,
          column: 1,
          raw: '*bold*',
        ),
      );
    });
    test('escaping', () {
      final parser = np.build(start: np.escaping).end();
      expectParse(
        parser,
        '\\*',
        const Escaping(
          escaped: '*',
          start: 0,
          line: 1,
          column: 1,
          raw: '\\*',
        ),
      );
    });
    test('url', () {
      final parser = np.build(start: np.url).end();
      expectParse(
        parser,
        '{link}',
        const Url(
          location: 'link',
          start: 0,
          line: 1,
          column: 1,
          raw: '{link}',
        ),
      );
    });
    test('norg whitespace', () {
      final parser = np.build(start: np.norgWhitespace).end();
      expectParse(
        parser,
        '  \t  ',
        const Whitespace(
          start: 0,
          line: 1,
          column: 1,
          raw: '  \t  ',
        ),
      );
    });
    test('plain text', () {
      final parser = np.build(start: np.plainText).end();
      expectParse(
        parser,
        'test',
        const PlainText(
          start: 0,
          line: 1,
          column: 1,
          raw: 'test',
        ),
      );
    });
  });
}

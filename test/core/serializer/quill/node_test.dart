import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_test/flutter_test.dart';
import 'package:groen/data/model/model.dart';
import 'package:groen/data/serializer/quill/node.dart';

void main() {
  group('NodeDeltaSerializer tests', () {
    const document = Document(
      start: 1,
      raw: 'Hello *world*',
      line: 1,
      column: 1,
      children: [
        Paragraph(
          start: 1,
          raw: 'Hello *world*',
          line: 1,
          column: 1,
          children: [
            ParagraphSegment(
              start: 1,
              raw: 'Hello *world*',
              line: 1,
              column: 1,
              children: <Node>[
                PlainText(
                  raw: 'Hello',
                  start: 1,
                  line: 1,
                  column: 1,
                ),
                Whitespace(
                  raw: ' ',
                  start: 1,
                  line: 1,
                  column: 1,
                ),
                AttachedModified(
                  type: AttachedModType.bold,
                  text: 'world',
                  raw: '*world*',
                  start: 1,
                  line: 1,
                  column: 1,
                ),
              ],
            ),
          ],
        ),
      ],
    );

    test('DocumentDeltaSerializer', () {
      const serializer = DocumentDeltaSerializer();
      final result = serializer.serializeNode(document);
      expect(result, isA<quill.Delta>());
      expect(result.toJson(), [
        {'insert': 'Hello '},
        {
          'insert': '*world*',
          'attributes': {'bold': true},
        },
      ]);
    });

    test('ParagraphDeltaSerializer', () {
      final paragraph = document.children!.first;
      const serializer = ParagraphDeltaSerializer();
      final result = serializer.serializeNode(paragraph as Paragraph);
      expect(result, isA<quill.Delta>());
      expect(result.toJson(), [
        {'insert': 'Hello '},
        {
          'insert': '*world*',
          'attributes': {'bold': true},
        },
      ]);
    });

    test('ParagraphSegmentDeltaSerializer', () {
      final paragraph = document.children!.first;
      final segment = paragraph.children!.first as ParagraphSegment;
      const serializer = ParagraphSegmentDeltaSerializer();
      final result = serializer.serializeNode(segment);
      expect(result, isA<quill.Delta>());
      expect(result.toJson(), [
        {'insert': 'Hello '},
        {
          'insert': '*world*',
          'attributes': {'bold': true},
        },
      ]);
    });

    test('UrlDeltaSerializer', () {
      const url = Url(
        raw: '{example.com}',
        start: 1,
        line: 1,
        column: 1,
        location: 'example.com',
      );
      const serializer = UrlDeltaSerializer();
      final result = serializer.serializeNode(url);
      expect(result, isA<quill.Delta>());
      expect(result.toJson(), [
        {
          'insert': '{example.com}',
          'attributes': {'link': 'example.com'}
        }
      ]);
    });

    test('AttachedModDeltaSerializer', () {
      const bold = AttachedModified(
        type: AttachedModType.bold,
        text: 'world',
        raw: '*world*',
        start: 1,
        line: 1,
        column: 1,
      );
      const serializer = AttachedModDeltaSerializer();
      final result = serializer.serializeNode(bold);
      expect(result, isA<quill.Delta>());
      expect(result.toJson(), [
        {
          'insert': '*world*',
          'attributes': {'bold': true},
        },
      ]);
    });
  });
}

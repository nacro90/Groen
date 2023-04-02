import 'node.dart';

class Paragraph extends Node {
  const Paragraph({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
    required super.children,
  });
}

class ParagraphSegment extends Node {
  const ParagraphSegment({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
    required super.children,
  });
}

import 'node.dart';

class PlainText extends Node {
  const PlainText({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  String get text => raw;
}

class Whitespace extends Node {
  const Whitespace({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  // @override
  // String toString() => _invisibleToString(this);
}

class LineEnding extends Node {
  const LineEnding({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  @override
  String toString() => _invisibleToString(this);
}

class ParagraphBreak extends Node {
  const ParagraphBreak({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  @override
  String toString() => _invisibleToString(this);
}

String _invisibleToString(Node node) =>
    '${node.runtimeType}(${node.start}, ${node.line}, ${node.column}, ${node.raw.codeUnits.map((c) => "U+$c")}, null)';

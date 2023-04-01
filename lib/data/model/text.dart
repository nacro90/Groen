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
}

class LineEnding extends Node {
  const LineEnding({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });
}

class ParagraphBreak extends Node {
  const ParagraphBreak({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });
}

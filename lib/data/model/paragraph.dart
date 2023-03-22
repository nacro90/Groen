import 'node.dart';

class Paragraph extends Node {
  final List<ParagraphSegment> segments;

  const Paragraph({
    required super.raw,
    required super.range,
    required this.segments,
  });

  @override
  List<Object?> get props => super.props + [segments];
}

class ParagraphSegment extends Node {
  final List<Node> elements;

  const ParagraphSegment({
    required super.raw,
    required super.range,
    required this.elements,
  });
}

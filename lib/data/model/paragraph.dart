import 'node.dart';

class Paragraph extends Node {
  final List<Node> nodes;

  const Paragraph({
    required this.nodes,
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  @override
  List<Object?> get props => super.props + [nodes];
}

class ParagraphSegment extends Node {
  final List<Node> nodes;

  const ParagraphSegment({
    required this.nodes,
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  @override
  List<Object?> get props => super.props + [nodes];
}

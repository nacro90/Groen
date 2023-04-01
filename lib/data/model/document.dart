import 'node.dart';

class Document extends Node {
  final List<Node> nodes;

  const Document({
    required this.nodes,
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  const Document.empty()
      : this(start: 1, line: 1, column: 1, raw: '', nodes: const []);

  @override
  List<Object?> get props => super.props + [nodes];
}

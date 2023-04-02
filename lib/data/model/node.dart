import 'package:equatable/equatable.dart';

abstract class NodeVisitor<T> {
  T visit(Node node);
}

abstract class Node extends Equatable {
  final int start;
  final int line;
  final int column;
  final String raw;
  final List<Node>? children;

  const Node({
    required this.start,
    required this.line,
    required this.column,
    required this.raw,
    this.children,
  });

  int get length => raw.length;

  int get stop => start + length;

  bool get isLeaf => children == null;

  T accept<T>(NodeVisitor<T> visitor) {
    return visitor.visit(this);
  }

  List<T> acceptRecursively<T>(NodeVisitor<T> visitor) {
    return <Node>[this, ...children ?? const []]
        .map(visitor.visit)
        .toList(growable: false);
  }

  @override
  List<Object?> get props => [start, line, column, raw, children];

  @override
  bool? get stringify => true;
}

class Empty extends Node {
  const Empty({required int start, required int line, required int column})
      : super(start: start, line: line, column: column, raw: '');
}

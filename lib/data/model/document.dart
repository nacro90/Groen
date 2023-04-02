import 'node.dart';

class Document extends Node {
  const Document({
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
    required super.children,
  });

  const Document.empty()
      : this(start: 1, line: 1, column: 1, raw: '', children: const []);
}

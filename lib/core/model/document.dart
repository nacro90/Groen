import 'node.dart';

class Document extends Node {
  final List<Node> elements;

  const Document({
    required super.raw,
    required super.range,
    required this.elements,
  });

  @override
  List<Object?> get props => super.props + [elements];
}

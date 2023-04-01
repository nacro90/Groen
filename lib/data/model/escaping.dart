import 'node.dart';

class Escaping extends Node {
  final String escaped;

  const Escaping({
    required this.escaped,
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  @override
  List<Object?> get props => super.props + [escaped];
}

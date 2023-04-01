import 'node.dart';

abstract class Link extends Node {
  final String location;
  final String? description;

  const Link({
    required this.location,
    this.description,
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  @override
  List<Object?> get props => super.props + [location, description];
}

class Url extends Link {
  const Url({
    required super.location,
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });
}

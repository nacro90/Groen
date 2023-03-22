import 'node.dart';

abstract class Link extends Node {
  final String location;
  final String? description;

  const Link({
    required super.raw,
    required super.range,
    required this.location,
    this.description,
  });
}

class Url extends Link {
  const Url({
    required super.raw,
    required super.range,
    required super.location,
  });
}

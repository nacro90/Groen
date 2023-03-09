import 'package:groen/norg/model/node.dart';

abstract class NorgLinkNode extends NorgNode {
  final String location;
  final String? description;

  const NorgLinkNode({
    required super.raw,
    required super.range,
    required this.location,
    this.description,
  });
}

class NorgUrl extends NorgLinkNode {
  const NorgUrl({
    required super.raw,
    required super.range,
    required super.location,
  });
}

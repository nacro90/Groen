import 'package:groen/norg/model/node.dart';

class NorgDocument extends NorgNode {
  final List<NorgNode> elements;

  const NorgDocument({
    required super.raw,
    required super.range,
    required this.elements,
  });

  @override
  List<Object?> get props => super.props + [elements];
}

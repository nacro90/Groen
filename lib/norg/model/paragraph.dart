import 'package:groen/norg/model/node.dart';

class NorgParagraph extends NorgNode {
  final List<NorgParagraphSegment> segments;

  const NorgParagraph({
    required super.raw,
    required super.range,
    required this.segments,
  });

  @override
  List<Object?> get props => super.props + [segments];
}

class NorgParagraphSegment extends NorgNode {
  final List<NorgNode> elements;

  const NorgParagraphSegment({
    required super.raw,
    required super.range,
    required this.elements,
  });
}

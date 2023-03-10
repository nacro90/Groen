enum PetitNorgType {
  document,
  paragraph,
  paragraphSegment,
  bold,
  italic,
  underline,
  strikethrough,
  spoiler,
  superscript,
  subscript,
  inlineCode,
  inlineComment,
  inlineMath,
  variable,
  link,
  url,
}

class PetitNorgNode {
  final PetitNorgType type;
  final List<PetitNorgNode> children;

  const PetitNorgNode({
    required this.type,
    required this.children,
  });
}

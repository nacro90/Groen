enum PetitNorgTokenType {
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

class PetitNorgToken {
  final PetitNorgTokenType type;
  final List<PetitNorgToken> children;

  const PetitNorgToken({
    required this.type,
    required this.children,
  });
}

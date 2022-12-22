import 'package:charcode/charcode.dart';

abstract class NorgNode {}

class NorgPlainText extends NorgNode {
  String content;

  NorgPlainText(this.content);
}

class NorgAttachedModifier extends NorgNode {
  NorgAttachedModifierType type;
  String content;

  NorgAttachedModifier({
    required this.type,
    required this.content,
  });
}

class NorgUrlLink extends NorgNode {
  String content;
  NorgUrlLink(this.content);
}

class NorgEscape extends NorgNode {}

enum NorgAttachedModifierType {
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
}

import 'package:charcode/charcode.dart';

/// The base type of all Norg AST objects
abstract class NorgNode {
  List<NorgNode> get children => const [];
}

class NorgDocument extends NorgNode {
  NorgContent content;

  NorgDocument(this.content);
}

/// A generic node that contains children
class NorgContent extends NorgNode {
  NorgContent(this.children);

  @override
  final List<NorgNode> children;
}

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

class NorgBold extends NorgAttachedModifier {
  NorgBold(String content)
      : super(type: NorgAttachedModifierType.bold, content: content);
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

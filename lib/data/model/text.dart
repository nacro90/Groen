import 'node.dart';

enum AttachedModifierType {
  bold,
  italic,
  underline,
  strikethrough,
  spoiler,
  superscript,
  subscript,
  inlineCode,
  inlineComment,
  // inlineMath,
  // variable,
}

AttachedModifierType attachedModTypeFromChar(String charStr) {
  switch (charStr) {
    case "*":
      return AttachedModifierType.bold;
    case "/":
      return AttachedModifierType.italic;
    case "_":
      return AttachedModifierType.underline;
    case "-":
      return AttachedModifierType.strikethrough;
    case "!":
      return AttachedModifierType.spoiler;
    case "^":
      return AttachedModifierType.superscript;
    case ",":
      return AttachedModifierType.subscript;
    case "`":
      return AttachedModifierType.inlineCode;
    case "%":
      return AttachedModifierType.inlineComment;
    default:
      throw ArgumentError.value(charStr);
  }
}

abstract class TextNode extends Node {
  final String text;

  const TextNode({
    required super.raw,
    required super.range,
    required this.text,
  });

  @override
  List<Object?> get props => super.props + [text];
}

class PlainText extends TextNode {
  const PlainText({
    required super.raw,
    required super.range,
    required super.text,
  });
}

class SimpleAttachedModifiedText extends TextNode {
  final AttachedModifierType type;

  const SimpleAttachedModifiedText({
    required super.raw,
    required super.range,
    required super.text,
    required this.type,
  });

  @override
  List<Object?> get props => super.props + [type];
}

class BoldText extends SimpleAttachedModifiedText {
  const BoldText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.bold);
}

class ItalicText extends SimpleAttachedModifiedText {
  const ItalicText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.italic);
}

class UnderlineText extends SimpleAttachedModifiedText {
  const UnderlineText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.underline);
}

class StrikethroughText extends SimpleAttachedModifiedText {
  const StrikethroughText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.strikethrough);
}

class SpoilerText extends SimpleAttachedModifiedText {
  const SpoilerText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.spoiler);
}

class SuperscriptText extends SimpleAttachedModifiedText {
  const SuperscriptText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.superscript);
}

class SubscriptText extends SimpleAttachedModifiedText {
  const SubscriptText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.subscript);
}

class InlineCodeText extends SimpleAttachedModifiedText {
  const InlineCodeText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.inlineCode);
}

class InlineCommentText extends SimpleAttachedModifiedText {
  const InlineCommentText({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: AttachedModifierType.inlineComment);
}

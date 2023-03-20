import 'package:flutter/material.dart';
import 'package:groen/norg/model/node.dart';

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
  // inlineMath,
  // variable,
}

NorgAttachedModifierType norgAttachedModifierTypeFromChar(String charStr) {
  switch (charStr) {
    case "*":
      return NorgAttachedModifierType.bold;
    case "/":
      return NorgAttachedModifierType.italic;
    case "_":
      return NorgAttachedModifierType.underline;
    case "-":
      return NorgAttachedModifierType.strikethrough;
    case "!":
      return NorgAttachedModifierType.spoiler;
    case "^":
      return NorgAttachedModifierType.superscript;
    case ",":
      return NorgAttachedModifierType.subscript;
    case "`":
      return NorgAttachedModifierType.inlineCode;
    case "%":
      return NorgAttachedModifierType.inlineComment;
    default:
      throw ArgumentError.value(charStr);
  }
}

abstract class NorgTextNode extends NorgNode {
  final String text;

  const NorgTextNode({
    required super.raw,
    required super.range,
    required this.text,
  });

  @override
  List<Object?> get props => super.props + [text];
}

class NorgPlainText extends NorgTextNode {
  const NorgPlainText({
    required super.raw,
    required super.range,
    required super.text,
  });
}

class NorgSimpleAttachedModifiedText extends NorgTextNode {
  final NorgAttachedModifierType type;

  const NorgSimpleAttachedModifiedText({
    required super.raw,
    required super.range,
    required super.text,
    required this.type,
  });

  @override
  List<Object?> get props => super.props + [type];
}

class NorgBold extends NorgSimpleAttachedModifiedText {
  const NorgBold({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.bold);
}

class NorgItalic extends NorgSimpleAttachedModifiedText {
  const NorgItalic({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.italic);
}

class NorgUnderline extends NorgSimpleAttachedModifiedText {
  const NorgUnderline({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.underline);
}

class NorgStrikethrough extends NorgSimpleAttachedModifiedText {
  const NorgStrikethrough({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.strikethrough);
}

class NorgSpoiler extends NorgSimpleAttachedModifiedText {
  const NorgSpoiler({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.spoiler);
}

class NorgSuperscript extends NorgSimpleAttachedModifiedText {
  const NorgSuperscript({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.superscript);
}

class NorgSubscript extends NorgSimpleAttachedModifiedText {
  const NorgSubscript({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.subscript);
}

class NorgInlineCode extends NorgSimpleAttachedModifiedText {
  const NorgInlineCode({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.inlineCode);
}

class NorgInlineComment extends NorgSimpleAttachedModifiedText {
  const NorgInlineComment({
    required super.raw,
    required super.range,
    required super.text,
  }) : super(type: NorgAttachedModifierType.inlineComment);
}

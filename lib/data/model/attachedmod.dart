import 'package:groen/data/string.dart';

import 'node.dart';

enum AttachedModType {
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

const charByAttachedMod = {
  AttachedModType.bold: '*',
  AttachedModType.italic: '/',
  AttachedModType.underline: '_',
  AttachedModType.strikethrough: '-',
  AttachedModType.spoiler: '!',
  AttachedModType.superscript: '^',
  AttachedModType.subscript: ',',
  AttachedModType.inlineCode: '`',
  AttachedModType.inlineComment: '%',
};

const attachedModByChar = {
  '*': AttachedModType.bold,
  '/': AttachedModType.italic,
  '_': AttachedModType.underline,
  '-': AttachedModType.strikethrough,
  '!': AttachedModType.spoiler,
  '^': AttachedModType.superscript,
  ',': AttachedModType.subscript,
  '`': AttachedModType.inlineCode,
  '%': AttachedModType.inlineComment,
};

final attachedModChars = Set.unmodifiable(attachedModByChar.keys);

extension AttachedModChar on AttachedModType {
  String get char => charByAttachedMod[this]!;
  int get charCode => char.codeUnit;
}

class AttachedModified extends Node {
  final AttachedModType mod;
  final String text;

  const AttachedModified({
    required this.mod,
    required this.text,
    required super.start,
    required super.line,
    required super.column,
    required super.raw,
  });

  @override
  List<Object?> get props => super.props + [mod, text];
}

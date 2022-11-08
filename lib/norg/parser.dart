import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:groen/norg/tokenizer.dart';
import 'package:groen/string_helpers.dart';

class Range extends Equatable {
  final int start;
  final int end;

  const Range(this.start, this.end);

  @override
  List<Object> get props => [start, end];

  @override
  bool get stringify => true;
}

abstract class TokenData {}

class Token extends Equatable {
  final Range range;
  final TokenData data;

  const Token(this.range, this.data);

  @override
  List<Object?> get props => [range, data];

  @override
  bool get stringify => true;
}

class Word with EquatableMixin implements TokenData {
  final String content;

  const Word(this.content);

  @override
  List<Object> get props => [content];

  @override
  bool get stringify => true;
}

class Space implements TokenData {
  const Space();

  @override
  String toString() {
    return 'Space()';
  }
}

class ParagraphBreak implements TokenData {
  const ParagraphBreak();

  @override
  String toString() {
    return 'ParagraphBreak()';
  }
}

class SoftBreak implements TokenData {
  const SoftBreak();

  @override
  String toString() {
    return 'SoftBreak()';
  }
}

enum LinkType {
  url,
}

class Link {
  final LinkType type;
  final List<Token> content;

  const Link(this.type, this.content);
}

enum AttachedModifierType {
  bold,
  italic,
  underline,
  superscript,
  subscript,
  strikethrough,
  comment,
  spoiler,
}

class AttachedModifier with EquatableMixin implements TokenData {
  final int char;
  final bool isOpening;
  final int? closingIndex;

  const AttachedModifier({
    required this.char,
    required this.isOpening,
    this.closingIndex,
  });

  @override
  List<Object?> get props => [char, isOpening];

  @override
  String toString() {
    return 'AttachedModifier(char: \'${String.fromCharCode(char)}\', isOpening: $isOpening, closingIndex: $closingIndex)';
  }
}

enum StructuralDetachedModifierType {
  heading,
}

class StructuralDetachedModifier {
  final StructuralDetachedModifierType type;
  final int level;

  const StructuralDetachedModifier(this.type, this.level);
}

// Token parseStructuralDetachedModifier(CountingHasNextIterator iter) {
//     if (iter.current.type != SimpleTokenType.newline)
//         return null;
//
//     const restorePoint = iterator.index;
//
//     const currentType = iterator.current().?.type;
//
//     var level: u16 = 1;
//
//     while (iterator.nextWithType(currentType)) |_|
//         level += 1;
//
//     const next = iterator.peekNext() orelse {
//         iterator.index = restorePoint;
//         return null;
//     };
//
//     return if (next.type == .Space) .{
//         .range = .{
//             .start = if (restorePoint == 0) restorePoint else restorePoint - 1,
//             .end = iterator.index,
//         },
//
//         .type = .{
//             .StructuralDetachedModifier = .{
//                 .type = .Heading, // TODO: Don't hardcode this
//                 .level = level,
//             },
//         },
//     } else null;
// }

class CountingHasNextIterator<T extends SimpleToken>
    extends HasNextIterator<T> {
  int counter = -1;
  T? current;
  T? prev;
  CountingHasNextIterator(super.iterator);

  @override
  T next() {
    counter++;
    prev = current;
    current = super.next();
    return current!;
  }

  T? nullableNext() {
    if (hasNext) return next();
    counter++;
    prev = current;
    current = null;
    return null;
  }
}

Token _parseWord(
  CountingHasNextIterator iter, {
  bool acceptAll = false,
  Iterable<SimpleToken>? initial,
}) {
  final buffer = StringBuffer();
  final start = iter.counter;
  initial?.forEach((token) => buffer.writeCharCode(token.char));
  while (acceptAll || iter.current?.type == SimpleTokenType.character) {
    buffer.writeCharCode(iter.current!.char);
    iter.nullableNext();
  }
  return Token(
    Range(start, iter.counter),
    Word(buffer.toString()),
  );
}

Token _parseSpace(CountingHasNextIterator iter) {
  final start = iter.counter;
  while (iter.current?.type == SimpleTokenType.space) {
    iter.nullableNext();
  }
  return Token(
    Range(start, iter.counter),
    const Space(),
  );
}

Token _parseNewline(CountingHasNextIterator iter, Map unclosedMap) {
  final start = iter.counter;
  TokenData breakType = const SoftBreak();
  iter.nullableNext();
  if (iter.current?.type == SimpleTokenType.newline) {
    unclosedMap.clear();
    breakType = const ParagraphBreak();
    iter.nullableNext();
  }
  return Token(
    Range(start, iter.counter),
    breakType,
  );
}

Token _parseSpecial(CountingHasNextIterator iter,
    Map<int, int> unclosedAttachedModifierMap, int tokenCounter) {
  final start = iter.counter;
  final prev = iter.prev;
  final current = iter.current!;
  final next = iter.nullableNext();

  final canBeAttachedModifier = next != current;
  final canBeOpeningModifier = prev == null ||
      prev.type == SimpleTokenType.space ||
      prev.type == SimpleTokenType.newline ||
      isPunctuation(prev.char) && next?.type == SimpleTokenType.character;
  final canBeClosingModifier = next == null ||
      next.type == SimpleTokenType.space ||
      next.type == SimpleTokenType.newline ||
      isPunctuation(next.char) && prev?.type == SimpleTokenType.character;

  if (canBeAttachedModifier && canBeOpeningModifier) {
    unclosedAttachedModifierMap[current.char] = tokenCounter;
    return Token(
      Range(start, iter.counter),
      AttachedModifier(
        char: current.char,
        isOpening: true,
      ),
    );
  } else if (canBeAttachedModifier && canBeClosingModifier) {
    return Token(
      Range(start, iter.counter),
      AttachedModifier(
        char: current.char,
        isOpening: false,
        closingIndex: unclosedAttachedModifierMap.remove(current.char),
      ),
    );
  } else {
    debugPrint('current: $current');
    return _parseWord(iter, initial: [current], acceptAll: true);
  }
}

Iterable<Token> parse(Iterable<SimpleToken> simpleTokens) sync* {
  final unclosedAttachedModifierMap = <int, int>{};
  final iter = CountingHasNextIterator(simpleTokens.iterator)..nullableNext();
  Token? lastParsedToken;
  var tokenCounter = 0;
  while (iter.current != null) {
    switch (iter.current!.type) {
      case SimpleTokenType.character:
        final wordToken = _parseWord(iter);
        lastParsedToken = wordToken;
        yield wordToken;
        break;

      case SimpleTokenType.space:
        final spaceToken = _parseSpace(iter);
        lastParsedToken = spaceToken;
        yield spaceToken;
        break;

      case SimpleTokenType.newline:
        final newlineToken = _parseNewline(iter, unclosedAttachedModifierMap);
        lastParsedToken = newlineToken;
        yield newlineToken;
        break;

      case SimpleTokenType.special:
        final specialToken =
            _parseSpecial(iter, unclosedAttachedModifierMap, tokenCounter);
        lastParsedToken = specialToken;
        yield specialToken;
        break;

      default:
        continue;
    }
    tokenCounter++;
  }
}

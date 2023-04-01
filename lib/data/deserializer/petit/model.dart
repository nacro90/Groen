import 'package:equatable/equatable.dart';
import 'package:petitparser/petitparser.dart';

enum ParseTokenType {
  document,
  paragraph,
  paragraphSegment,
  url,
  attachedModifier,
  escaping,
}

class ParseToken extends Equatable {
  final ParseTokenType type;
  final int start;
  final int line;
  final int column;
  final List items;
  final String raw;

  const ParseToken({
    required this.type,
    required this.start,
    required this.line,
    required this.column,
    required this.items,
    required this.raw,
  });

  ParseToken.token(ParseTokenType type, Token token)
      : this(
          type: type,
          start: token.start,
          line: token.line,
          column: token.column,
          items: token.value,
          raw: token.input,
        );

  int get length => raw.length;

  int get stop => start + length;

  @override
  List<Object?> get props => [type, start, line, column, items, raw];
}

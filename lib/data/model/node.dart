import 'package:equatable/equatable.dart';

abstract class Node extends Equatable {
  final int start;
  final int line;
  final int column;
  final String raw;

  const Node({
    required this.start,
    required this.line,
    required this.column,
    required this.raw,
  });

  int get length => raw.length;

  int get stop => start + length;

  @override
  List<Object?> get props => [start, line, column, raw];

  @override
  bool? get stringify => true;
}

class Empty extends Node {
  const Empty({required int start, required int line, required int column})
      : super(start: start, line: line, column: column, raw: '');
}

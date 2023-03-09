import 'package:equatable/equatable.dart';

class Range extends Equatable {
  final int start;
  final int end;

  const Range(this.start, this.end);

  int get length => end - start;

  bool isContaining(Range range) => start <= range.start && end >= range.end;

  Iterable<int> get iter => Iterable.generate(length, (elem) => elem + start);

  @override
  List<Object?> get props => [start];

  @override
  bool? get stringify => true;
}

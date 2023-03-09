import 'package:equatable/equatable.dart';
import 'package:groen/norg/model/range.dart';

abstract class NorgNode extends Equatable {
  final Range range;
  final String raw;

  const NorgNode({
    required this.raw,
    required this.range,
  });

  @override
  List<Object?> get props => [range, raw];

  @override
  bool? get stringify => true;
}

import 'package:equatable/equatable.dart';

import 'range.dart';

abstract class Node extends Equatable {
  final Range range;
  final String raw;

  const Node({
    required this.raw,
    required this.range,
  });

  @override
  List<Object?> get props => [range, raw];

  @override
  bool? get stringify => true;
}

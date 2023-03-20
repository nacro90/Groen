import 'package:flutter/material.dart';

/// [FutureBuilder] with just two states that the generic type [T] does exist or not.
/// If [T] does not exist, the [fallback] builder will be called if it is not null.
class TwoStateFutureBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext, T) builder;
  final Future<T> future;
  final Widget Function(BuildContext)? fallback;

  const TwoStateFutureBuilder({
    super.key,
    required this.builder,
    required this.future,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final finalFallback = fallback ?? _buildEmpty;

    return FutureBuilder<T>(
      future: future,
      builder: ((context, snapshot) => _isBuildable(snapshot)
          // ignore: null_check_on_nullable_type_parameter
          ? builder(context, snapshot.data!)
          : finalFallback(context)),
    );
  }

  bool _isBuildable(AsyncSnapshot<T> snapshot) =>
      snapshot.hasData && snapshot.data != null;

  Widget _buildEmpty(BuildContext _) => const SizedBox.shrink();
}

import 'package:flutter/widgets.dart';

import 'pool_scope.dart';

/// Typedef of builder function
typedef AnimatedWidgetBuilder = Widget Function(
  BuildContext context,
  Animation animation,
);

class AnimPoolWidget extends StatefulWidget {
  /// Builder function for nested animations, you can pass your [AnimationController] to many Animations/Transitions
  final AnimatedWidgetBuilder builder;

  /// Index of item in SliverList/ListView
  final int index;

  /// UNTESTED, DROPS ERROR ON SCALE AND SIZE TRANSITION, WORKS ON FADE TRANSITION
  ///
  /// NEEDS TESTING
  const AnimPoolWidget({Key? key, required this.builder, required this.index}) : super(key: key);

  @override
  State<AnimPoolWidget> createState() => _AnimPoolWidgetState();
}

class _AnimPoolWidgetState extends State<AnimPoolWidget> {
  @override
  Widget build(BuildContext context) =>
      widget.builder(context, AnimationPoolScope.getFromPool(context, widget.index));
}

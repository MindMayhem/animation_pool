import 'package:flutter/material.dart';

class AnimationPoolScope extends InheritedWidget {
  AnimationPoolScope(
      {Key? key,
      required child,
      required this.tickerProvider,
      this.maxAnimCount = 10,

      /// Duration of animation controller, by default is (milliseconds:350)
      this.duration = const Duration(milliseconds: 350)})
      : super(
          key: key,
          child: child,
        );

  /// List of initialized controllers, limited by [maxAnimCount] (by default - 10)
  final List<AnimationController> _initializedAnimControllers = [];

  /// Maximum count of existing animation controllers, by default - 10
  ///
  /// Best practice: (maximum count of items on screen) + 3-4 for preloading
  final int maxAnimCount;

  /// [tickerProvider] required for creating [AnimationController]'s
  final TickerProvider tickerProvider;

  /// Default duration for all [AnimationController]'s
  ///
  /// There's no possibility to set custom duration for every controller
  final Duration duration;

  /// Get count of available controllers
  int get controllersCount => _initializedAnimControllers.length;

  /// Returns [AnimationController] by given from pool and animate it
  ///
  /// Lazily creates new [AnimationController] if it doesn't exist and saves it
  /// to [_initializedAnimControllers]
  ///
  /// [index] give us possibility to take correct AnimationController from pool
  static AnimationController getFromPool(BuildContext context, int index) {
    final scope = _of(context);
    // Face palm...
    if ((scope?.controllersCount ?? 1) < (scope?.maxAnimCount ?? 0)) {
      scope?._initializedAnimControllers
          .add(AnimationController(vsync: scope.tickerProvider, duration: scope.duration));
    }
    return scope?._initializedAnimControllers[index % scope.controllersCount] ??
        AnimationController(vsync: scope!.tickerProvider)
      ..reset()
      ..forward();
  }

  /// Disposes all AnimationControllers in current scope
  static void disposeControllers(BuildContext context) {
    final scope = _of(context);
    if (scope != null) for (final item in scope._initializedAnimControllers) item.dispose();
  }

  /// Get current scope of [AnimationPoolScope]
  static AnimationPoolScope? _of(BuildContext context) {
    final scope = context.getElementForInheritedWidgetOfExactType<AnimationPoolScope>()?.widget
        as AnimationPoolScope?;
    return scope;
  }

  @override
  bool updateShouldNotify(covariant AnimationPoolScope oldWidget) =>
      oldWidget.maxAnimCount != maxAnimCount;
}

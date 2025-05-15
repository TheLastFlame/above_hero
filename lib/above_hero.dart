import 'dart:async';

import 'package:flutter/material.dart';

/// A widget that allows its [child] to be displayed above a [Hero] animation
/// during page transitions.
///
/// Flutter's [Hero] widgets are typically rendered on top of all other content
/// during page transitions. In doing so, it overlaps the page elements
/// under which it should be placed
///
/// AboveHero solves this problem by transferring the position of its [child]
/// to the very top of the navigation overlay's layer hierarchy, where pages
/// and the Hero widget itself are also located.
///
/// Usage Example:
/// ```dart
/// Stack(
///   children: <Widget>[
///     // Your page content
///     Hero(tag: "myHero", child: MyHeroContent()),
///     Positioned(
///       top: 16,
///       left: 16,
///       child: AboveHero(
///         child: ElevatedButton(
///           onPressed: () => Navigator.pop(context),
///           child: Icon(Icons.arrow_back),
///         ),
///       ),
///     ),
///   ],
/// )
/// ```
class AboveHero extends StatefulWidget {
  /// Creates a widget that attempts to keep its [child] above [Hero] animations.
  const AboveHero(
      {super.key, required this.child, this.transitionOnUserGestures = false});

  /// The widget to display above [Hero] animations.
  final Widget child;

  /// Whether the [child] should also attempt to stay above transitions
  /// triggered by user gestures (e.g., swipe-to-go-back).
  ///
  /// Defaults to `false`.
  final bool transitionOnUserGestures;

  @override
  State<AboveHero> createState() => _AboveHeroState();
}

class _AboveHeroState extends State<AboveHero> {
  OverlayEntry? _overlayEntry;
  Animation<double>? _animation;
  ValueNotifier<bool>? _userGestureNotifier;
  final _layerLink = LayerLink();
  Size? _childSize;
  bool _showChild = true;

  final _key = GlobalKey();
  late final _child = KeyedSubtree(key: _key, child: widget.child);

  void _handleStatusChange([AnimationStatus? status]) async {
    final route = ModalRoute.of(context);

    if (route == null) return;

    if (route.popGestureInProgress && !widget.transitionOnUserGestures) {
      return;
    }

    final isTransitioning =
        (status?.isAnimating ?? false) || route.popGestureInProgress;

    if (!isTransitioning) {
      if (route.navigator?.overlay?.mounted ?? false) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
      _showChild = true;
      setState(() {});
      return;
    }

    if (_overlayEntry == null) {
      final RenderBox? renderBox =
          _key.currentContext?.findRenderObject() as RenderBox?;
      _childSize = renderBox?.size;

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return route.buildTransitions(
            context,
            route.animation!,
            route.secondaryAnimation!,
            CompositedTransformFollower(
              link: _layerLink,
              // Fight against widgets like Container that try to expand uncontrollably to the whole screen
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: _childSize?.height,
                  width: _childSize?.width,
                  child: _child,
                ),
              ),
            ),
          );
        },
      );

      // The timing for inserting the overlay is critical to avoid visual glitches.
      // If a route transition is initiated by a user gesture (e.g., swipe to go back),
      // the Hero widget might appear a frame earlier than if navigation is triggered
      // programmatically (e.g., Navigator.push/pop).
      //
      // - For gesture-based navigation (`route.popGestureInProgress == true`):
      //   A microtask (`Future.microtask`) is sufficient to schedule the overlay
      //   insertion after the Hero has been prepared but before the next frame,
      //   preventing a flicker where the Hero momentarily obscures the child.
      //
      // - For programmatic navigation (`route.popGestureInProgress == false`):
      //   The Hero animation might not be ready within a microtask. Waiting until
      //   the end of the current frame (`WidgetsBinding.instance.endOfFrame`)
      //   ensures that the Hero is fully set up before the overlay is inserted.
      //   This prevents the child from appearing too early or without the correct
      //   transition context.
      if (!route.popGestureInProgress) await WidgetsBinding.instance.endOfFrame;

      Future.microtask(() {
        if (!mounted) return;

        route.navigator?.overlay?.insert(_overlayEntry!);
        _showChild = false;
        setState(() {});
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);

    if (widget.transitionOnUserGestures) {
      _userGestureNotifier = route?.navigator?.userGestureInProgressNotifier;

      _userGestureNotifier?.addListener(_handleStatusChange);
    }

    if (route?.animation != null) {
      _animation = route!.animation;
      _animation!.addStatusListener(_handleStatusChange);

      _handleStatusChange(_animation!.status);
    }
  }

  @override
  void dispose() {
    _userGestureNotifier?.removeListener(_handleStatusChange);

    _animation?.removeStatusListener(_handleStatusChange);

    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: _showChild
          ? _child
          : SizedBox(width: _childSize?.width, height: _childSize?.height),
    );
  }
}

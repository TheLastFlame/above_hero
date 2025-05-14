import 'dart:async';

import 'package:flutter/material.dart';

class AboveHero extends StatefulWidget {
  const AboveHero({super.key, required this.child});

  final Widget child;

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

  final key = GlobalKey();
  late final child = KeyedSubtree(key: key, child: widget.child);

  void _handleStatusChange([AnimationStatus? status]) async {
    final route = ModalRoute.of(context);

    if (route == null) return;

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
          key.currentContext?.findRenderObject() as RenderBox?;
      _childSize = renderBox?.size;

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return CompositedTransformFollower(
            link: _layerLink,
            child: route.buildTransitions(
              context,
              route.animation!,
              route.secondaryAnimation!,
              // Fight against widgets like Container that try to expand uncontrollably to the whole screen
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: _childSize?.height,
                  width: _childSize?.width,
                  child: child,
                ),
              ),
            ),
          );
        },
      );

      //This is one big meme. If you use addPostframeCallback, when you use the gesture
      //to go back, the Hero will appear a frame earlier, causing a flicker.
      //And one microtask is enough to appear after Hero. But if navigation is invoked via Navigator,
      //Hero won't appear in time, and we need to wait until the frame is complete.

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

    _userGestureNotifier = route?.navigator?.userGestureInProgressNotifier;

    _userGestureNotifier?.addListener(_handleStatusChange);

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
          ? child
          : SizedBox(width: _childSize?.width, height: _childSize?.height),
    );
  }
}

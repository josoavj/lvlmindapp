//import 'package:flutter/animation.dart';
import 'dart:async'; // Bibliothèque utile pour l'ensemble du code
import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  const DelayedAnimation({super.key, required this.delay, required this.child});

  @override
  // ignore: library_private_types_in_public_api
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;
  @override
  void initState() {
    super.initState();

    controller();

    final curve = curvedAnimate();

    animateOffset(curve);

    time();
  }

  Timer time() {
    return Timer(Duration(milliseconds: widget.delay), () {
    _controller.forward();
  });
  }

  Animation<Offset> animateOffset(CurvedAnimation curve) {
    return _animOffset = Tween<Offset>(
    begin: const Offset(0.0, -0.35),
    end: Offset.zero,
  ).animate(curve);
  }

  CurvedAnimation curvedAnimate() {
    return CurvedAnimation(
    parent: _controller,
    curve: Curves.decelerate,
  );
  }

  AnimationController controller() {
    return _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}

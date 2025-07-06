// lib/animations/delayed_animation.dart (ou simpleDelayedAnimation.dart si c'est son nom)

import 'dart:async' show Timer;
import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final Duration animationDuration;
  final Curve curve;
  final Offset slideStartOffset;

  const DelayedAnimation({
    super.key,
    required this.delay,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.slideStartOffset = const Offset(0.0, -0.35),
  });

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    // Assurez-vous que ces initialisations sont synchrones et complètes
    _slideAnimation = Tween<Offset>(
      begin: widget.slideStartOffset,
      end: Offset.zero,
    ).animate(curvedAnimation);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    // Le Timer déclenche uniquement le forward() du contrôleur
    if (widget.delay == 0) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Les animations _fadeAnimation et _slideAnimation doivent être initialisées ici.
    // Si _controller.forward() n'a pas été appelé, elles ont toujours leurs valeurs de début (0.0 pour opacité, slideStartOffset pour position)
    // C'est pourquoi elles sont initialisées dans initState et devraient être prêtes.
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
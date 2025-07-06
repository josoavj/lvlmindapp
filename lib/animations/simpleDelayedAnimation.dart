// ignore_for_file: file_names

import 'dart:async' show Timer;
import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay; // Délai avant le début de l'animation en millisecondes
  final Duration animationDuration; // Durée de l'animation elle-même
  final Curve curve; // Courbe de l'animation pour plus de fluidité
  final Offset slideStartOffset; // Position de début du glissement

  const DelayedAnimation({
    super.key,
    required this.delay,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 800), // Durée par défaut
    this.curve = Curves.easeOutCubic, // Courbe plus dynamique par défaut
    this.slideStartOffset = const Offset(0.0, -0.35), // Offset initial par défaut
  });

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation; // Utilisation explicite pour la clarté

  @override
  void initState() {
    super.initState();

    // 1. Initialisation du contrôleur d'animation
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration, // Utilise la durée configurable
    );

    // 2. Définition des animations (Slide et Fade)
    // La courbe est maintenant configurable via les propriétés du widget.
    // CurvedAnimation est créé une seule fois et partagé par les deux animations.
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve, // Utilise la courbe configurable
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.slideStartOffset, // Offset de début configurable
      end: Offset.zero, // Arrive à la position finale
    ).animate(curvedAnimation); // Animation basée sur la courbe définie

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Commence complètement transparent
      end: 1.0, // Finit complètement opaque
    ).animate(curvedAnimation); // Animation basée sur la même courbe

    // 3. Déclenchement de l'animation après le délai spécifié
    if (widget.delay == 0) {
      // Si le délai est 0, on démarre immédiatement
      _controller.forward();
    } else {
      // Sinon, on utilise un Timer pour le délai
      Timer(Duration(milliseconds: widget.delay), () {
        if (mounted) { // Vérifie si le widget est toujours monté avant d'animer
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    // Très important : libérer les ressources de l'AnimationController
    // pour éviter les fuites de mémoire.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
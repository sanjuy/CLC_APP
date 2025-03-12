import 'dart:math';
import 'package:clc_app/resources/extenssions.dart';
import 'package:flutter/material.dart';

class LoadingIndicator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static OverlayEntry? _overlayEntry;
  static late AnimationController _controller;
  static late Animation<double> _animation;

  static void show() {
    if (_overlayEntry != null) return;

    final navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;

    final overlayState = navigatorState.overlay;
    if (overlayState == null) return;

    _controller = AnimationController(
      vsync: navigatorState,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          const ModalBarrier(color: Color(0x80000000), dismissible: false),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: Image.asset("logo.png".directory(), scale: 15),
                );
              },
            ),
          ),
        ],
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      overlayState.insert(_overlayEntry!);
    });
  }

  static void hide() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _controller.dispose();
    }
  }
}

import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  Bounce({
    super.key,
    required this.child,
    required this.startAction,
    required this.endAction,
    required this.endState,
  });

  final Widget child;
  final Function startAction;
  final Function endAction;
  final bool endState;

  @override
  State<Bounce> createState() => BounceState();
}

class BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  late double _scale;

  late AnimationController _animate;

  @override
  void initState() {
    _animate = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      lowerBound: 0.0,
      upperBound: 0.04,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animate.dispose();
    super.dispose();
  }

  void _onTapDown() {
    widget.startAction(true);
    _animate.forward();
  }

  void _onTapUp() {
    if (widget.endState == true) {
      widget.endAction();
      _animate.reverse();
      widget.startAction(false);
    }
  }

  void _onTapCancel() {
    _animate.reverse();
    widget.startAction(false);
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value;
    return Listener(
      onPointerDown: (details) => _onTapDown(),
      onPointerUp: (details) => _onTapUp(),
      onPointerMove: (onPonterEvent) => _onTapCancel(),
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}

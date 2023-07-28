import 'package:flutter/material.dart';

class SizeAnimationButton extends StatefulWidget {
  final Duration duration;
  final Curve curve;
  final bool onTurn;

  SizeAnimationButton({
    required this.onTurn,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  _SizeAnimationButtonState createState() => _SizeAnimationButtonState();
}

class _SizeAnimationButtonState extends State<SizeAnimationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation =
        Tween<double>(begin: widget.onTurn ? 0 : 0, end: widget.onTurn ? 1 : 1)
            .animate(_controller);
    _runTurnCheck();
  }

  void _runTurnCheck() {
    _controller.forward(from: 0.5);
  }

  @override
  void didUpdateWidget(SizeAnimationButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runTurnCheck();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Center(
        child: Icon(widget.onTurn
            ? Icons.keyboard_arrow_up_rounded
            : Icons.keyboard_arrow_down_rounded),
      ),
    );
  }
}

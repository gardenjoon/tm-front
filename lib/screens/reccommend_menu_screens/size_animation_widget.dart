import 'package:flutter/material.dart';

class SizeAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool expand;

  SizeAnimationWidget({
    required this.child,
    required this.expand,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  _SizeAnimationWidgetState createState() => _SizeAnimationWidgetState();
}

class _SizeAnimationWidgetState extends State<SizeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (widget.expand) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(SizeAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: _animation,
      child: widget.child,
    );
  }
}

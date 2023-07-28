import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class ResetButton extends StatefulWidget {
  const ResetButton({super.key, required this.func});
  final Function() func;

  @override
  State<ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends State<ResetButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onClick() async {
    widget.func();
    await controller.forward();
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Palette.white,
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          visualDensity: VisualDensity.comfortable,
          onPressed: onClick,
          splashColor: Colors.transparent,
          iconSize: 34,
          icon: Icon(Icons.refresh_rounded),
        ),
      ),
    );
  }
}
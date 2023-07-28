import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({super.key, required this.loadingTextWidget});

  final Widget loadingTextWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/loading.gif',
          width: 100,
          height: 100,
          colorBlendMode: BlendMode.multiply,
        ),
        SizedBox(height: 20),
        loadingTextWidget,
      ],
    );
  }
}

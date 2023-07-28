import 'package:flutter/material.dart';

class CustomMarkerWidget extends StatefulWidget {
  const CustomMarkerWidget({
    Key? key,
    required this.onFinishRendering,
  }) : super(key: key);

  final void Function(GlobalKey globalKey) onFinishRendering;

  @override
  State<CustomMarkerWidget> createState() => _CustomMarkerWidgetState();
}

class _CustomMarkerWidgetState extends State<CustomMarkerWidget> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTheMarker();
    });
  }

  Future<void> loadTheMarker() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onFinishRendering(_globalKey);
    });
  }

  Widget _renderAMarker() {
    return Image.asset('assets/images/location_circle.png');
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: _renderAMarker(),
    );
  }
}

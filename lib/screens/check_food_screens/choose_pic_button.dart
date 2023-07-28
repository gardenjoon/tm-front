import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoosePicButton extends StatelessWidget {
  const ChoosePicButton({
    super.key,
    required this.function,
    required this.isCamera,
  });

  final Function() function;
  final bool isCamera;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 640),
        height: 68,
        //   width: Get.width * 50 / 100,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: 18),
          onPressed: function,
          color: isCamera ? Colors.indigo.shade50 : Colors.indigo.shade400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isCamera ? Icons.photo_camera : Icons.photo_library,
                size: 40,
                color: isCamera ? Colors.black : Colors.white,
              ),
              SizedBox(width: 20),
              Text(
                isCamera ? '사진 촬영' : '사진 선택',
                style: TextStyle(
                  color: isCamera ? Colors.indigo.shade400 : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

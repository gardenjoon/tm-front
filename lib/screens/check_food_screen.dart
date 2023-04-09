import 'package:flutter/material.dart';

class CheckFood extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  CheckFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          "음식확인",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 160),
                  color: Colors.indigo.shade50,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.photo_camera,
                        size: 60,
                      ),
                      Text(
                        '사진 촬영',
                        style: TextStyle(
                          color: Colors.indigo.shade400,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 160),
                  color: Colors.indigo.shade400,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.photo_library,
                        size: 60,
                        color: Colors.white,
                      ),
                      Text(
                        '사진 선택',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

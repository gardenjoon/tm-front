import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class VisibleIcon extends StatelessWidget {
  VisibleIcon({super.key, required this.isObscure});
  RxBool isObscure;

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          visualDensity: VisualDensity.comfortable,
          onPressed: () {
            isObscure.value = !isObscure.value;
          },
          splashColor: Colors.transparent,
          iconSize: 20,
          icon: Icon(
            isObscure.value ? Icons.visibility : Icons.visibility_off,
          ),
        ));
  }
}

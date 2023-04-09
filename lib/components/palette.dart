import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Palette {
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color blackOpacity = Color.fromRGBO(0, 0, 0, 0.4);
  static const Color greyOpacity = Color.fromRGBO(51, 51, 51, 0.4);
  static const Color greyMain = Color.fromRGBO(112, 112, 112, 1);
  static const Color greySub = Color.fromARGB(255, 191, 191, 191);
  static const Color greySub2 = Color.fromRGBO(244, 244, 244, 1);
  static const Color red = Color.fromRGBO(230, 84, 84, 1);
  static const Color yellowMain = Color.fromRGBO(255, 204, 72, 1);
  static const Color yellowSub = Color.fromRGBO(255, 217, 118, 1);
  static const Color blueMain = Color.fromRGBO(44, 190, 255, 1);
  static const Color blueSub = Color.fromRGBO(96, 206, 255, 1);
  static const Color logoMain = Color.fromRGBO(255, 69, 20, 1);
  static const Color mainBackgroud = Color(0xfff5f7fd);
  static const Color main = Color(0xff5c74dd);
}

class Assets extends StatelessWidget {
  const Assets(this.asset, {super.key, this.size = 10, this.color = Palette.black});
  final String asset;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      chooseAsset(asset),
      color: color,
      width: size,
      height: size,
    );
  }

  String chooseAsset(String asset) {
    if (asset == "addFriends") {
      return "assets/svg/addF.svg";
    } else if (asset == "bell") {
      return "assets/svg/bell.svg";
    } else if (asset == "home") {
      return "assets/svg/home.svg";
    } else if (asset == "map") {
      return "assets/svg/map.svg";
    } else {
      return "assets/svg/profile.svg";
    }
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {super.key, 
    this.color = Palette.black,
    required this.size,
    required this.weight,
    required this.family,
    required this.align,
    this.isLogo = false,
  });
  final String text;
  final Color color;
  final String size;
  final String weight;
  final String family;
  final String align;
  final bool isLogo;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign(align: align),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          color: color,
          fontSize: fontSize(size: size),
          fontWeight: fontWeight(weight: weight),
          fontFamily: family,
          height: !isLogo ? 1.5 : 1,
        ));
  }

  double fontSize({required String size}) {
    if (size == "logo") {
      return 50;
    } else if (size == "title") {
      return 22;
    } else if (size == "subtitle") {
      return 20;
    } else if (size == "small") {
      return 12;
    } else if (size == "smaller") {
      return 10;
    } else {
      return 16;
    }
  }

  FontWeight fontWeight({String? weight}) {
    if (weight == "bold") {
      return FontWeight.bold;
    } else if (weight == "semibold") {
      return FontWeight.w600;
    } else {
      return FontWeight.normal;
    }
  }

  TextAlign textAlign({String? align}) {
    if (align == "left") {
      return TextAlign.start;
    } else if (align == "right") {
      return TextAlign.end;
    } else if (align == "justify") {
      return TextAlign.justify;
    } else {
      return TextAlign.center;
    }
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(this.hint, this.border, this.controller, {super.key});
  final String hint;
  final String border;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Palette.greySub,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: chooseBorder(border),
        enabledBorder: chooseBorder(border),
        focusedBorder: chooseBorder(border),
        suffixIcon: GestureDetector(
          child: const Icon(
            Icons.cancel,
            color: Palette.greySub,
            size: 20,
          ),
          onTap: () => controller.clear(),
        ),
      ),
    );
  }

  InputBorder chooseBorder(String border) {
    if (border == "none") {
      return InputBorder.none;
    } else {
      return const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            style: BorderStyle.none,
          ));
    }
  }
}

BoxDecoration cardDecoration(String image) {
  return BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage(image),
      colorFilter:
          const ColorFilter.mode(Palette.greyOpacity, BlendMode.darken),
    ),
  );
}

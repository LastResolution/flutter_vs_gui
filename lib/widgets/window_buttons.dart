import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFFd6d6d6),
    mouseOver: const Color(0xBB3d3d3d),
    mouseDown: const Color(0xAA383838),
    iconMouseOver: const Color(0xFFd6d6d6),
    iconMouseDown: const Color(0xFFd6d6d6));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xBB3d3d3d),
    mouseDown: const Color(0xAA383838),
    iconNormal: const Color(0xFFB1B1B1),
    iconMouseOver: const Color(0xFFB1B1B1));

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

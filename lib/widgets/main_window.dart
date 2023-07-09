import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_lifecycle/desktop_lifecycle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vs_gui/widgets/window_buttons.dart';

class MainWindow extends StatefulWidget {
  final String title;
  final Widget child;
  const MainWindow({super.key, required this.title, required this.child});

  @override
  MainWindowState createState() => MainWindowState();
}

class MainWindowState extends State<MainWindow> {
  final ValueListenable<bool> activeEvent = DesktopLifecycle.instance.isActive;
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    activeEvent.addListener(() {
      setState(() {
        isActive = activeEvent.value;
      });
    });
    return Scaffold(
        body: WindowBorder(
            width: 1,
            color: isActive ? const Color(0xFF7160e8) : const Color(0xFF3D3D3D),
            child: Container(
                color: const Color(0xFF1f1f1f),
                child: Column(children: [
                  WindowTitleBarBox(
                    child: Row(children: [
                      Expanded(
                          child: MoveWindow(
                        child: Row(children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Image.asset(isActive
                                  ? "images/active_icon.png"
                                  : "images/deactive_icon.png")),
                          Flexible(
                              child: Text(
                            widget.title,
                            style: const TextStyle(color: Color(0xFFd6d6d6)),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          ))
                        ]),
                      )),
                      const WindowButtons()
                    ]),
                  ),
                  Expanded(child: widget.child),
                  Container(
                    height: 24,
                    width: double.infinity,
                    color: const Color(0xFF424242),
                    child: const Row(children: [
                      Padding(
                          padding: EdgeInsets.all(3),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            size: 18,
                            color: Color(0xFFE5E5E5),
                          )),
                      Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            "Ready",
                            style: TextStyle(
                                color: Color(0xFFE5E5E5), fontSize: 12),
                          )),
                    ]),
                  )
                ]))));
  }
}

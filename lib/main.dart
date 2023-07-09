import 'package:desktop_lifecycle/desktop_lifecycle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'widgets/window_buttons.dart';

void main() {
  runApp(const App());
  doWhenWindowReady(() {
    final win = appWindow;
    win.title = "Visual Studio Like GUI";
    win.minSize = const Size(300, 200);
    win.show();
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainWindow(
          title: 'Visual Studio Like GUI',
          child: Container(),
        ));
  }
}

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
                  widget.child
                ]))));
  }
}

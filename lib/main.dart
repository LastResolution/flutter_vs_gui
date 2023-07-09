import 'package:desktop_lifecycle/desktop_lifecycle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/window_buttons.dart';

void main() {
  runApp(const App());
  doWhenWindowReady(() {
    final win = appWindow;
    win.title = "VisualStudio Like GUI";
    win.minSize = const Size(300, 500);
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
            title: 'VisualStudio Like GUI',
            child: Container(
              alignment: Alignment.center,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(
                  "images/vs_logo_large.svg",
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF151515), BlendMode.srcIn),
                ),
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "This app is VisualStudio like GUI's demo.",
                          style: TextStyle(
                              color: Color(0x77FFFFFF),
                              fontWeight: FontWeight.bold),
                        )))
              ]),
            )));
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
                  Expanded(child: widget.child)
                ]))));
  }
}

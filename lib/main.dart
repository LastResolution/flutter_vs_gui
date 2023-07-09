import 'package:desktop_lifecycle/desktop_lifecycle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_svg/svg.dart';

import 'util/url_launcher.dart';
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
                        ))),
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child: SvgPicture.asset("images/github-mark.svg",
                                colorFilter: const ColorFilter.mode(
                                    Color(0x77FFFFFF), BlendMode.srcIn))),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () async {
                                await launchInBrowser(
                                    "https://github.com/LifeViolation/");
                              },
                              child: const Text(
                                "LifeViolation",
                                style: TextStyle(
                                    color: Color(0x77FFFFFF),
                                    fontSize: 24,
                                    decoration: TextDecoration.underline),
                              ),
                            )),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await launchInBrowser(
                            "https://github.com/LifeViolation/flutter_vs_gui");
                      },
                      child: const Text(
                        "LifeViolation/flutter-vs-gui",
                        style: TextStyle(
                            color: Color(0x77FFFFFF),
                            fontSize: 18,
                            decoration: TextDecoration.underline),
                      ),
                    ))
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

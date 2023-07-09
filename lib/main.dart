import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'widgets/window_buttons.dart';

void main() {
  runApp(const App());
  doWhenWindowReady(() {
    final win = appWindow;
    win.title = "Visual Studio Like GUI";
    win.show();
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MainWindow());
  }
}

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  MainWindowState createState() => MainWindowState();
}

class MainWindowState extends State<MainWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WindowBorder(
            width: 1,
            color: const Color(0xFF7160e8),
            child: Container(
                color: const Color(0xFF1f1f1f),
                child: Column(children: [
                  WindowTitleBarBox(
                    child: Row(children: [
                      Expanded(child: MoveWindow()),
                      const WindowButtons()
                    ]),
                  )
                ]))));
  }
}

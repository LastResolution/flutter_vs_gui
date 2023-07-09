import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vs_gui/widgets/main_window.dart';
import 'package:window_manager/window_manager.dart';

import 'util/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
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
            visibleStatusBar: true,
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
                            padding: const EdgeInsets.only(left: 10),
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

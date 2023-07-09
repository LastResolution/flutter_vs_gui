import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

Future<void> launchInBrowser(String url) async {
  await UrlLauncherPlatform.instance.launch(
    url,
    useSafariVC: false,
    useWebView: false,
    enableJavaScript: false,
    enableDomStorage: false,
    universalLinksOnly: false,
    headers: <String, String>{},
  );
}

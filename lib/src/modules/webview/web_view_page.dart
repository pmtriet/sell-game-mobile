import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../generated/colors.gen.dart';
import '../../common/extensions/build_context_x.dart';

@RoutePage()
class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final controller = WebViewController();
  int progress = 0;
  @override
  void initState() {
    super.initState();

    controller
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              progress = progress;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              progress = 100;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: context.router.maybePop,
              icon: const Icon(
                Icons.arrow_back,
                color: ColorName.primary,
              )),
          titleSpacing: 0,
          surfaceTintColor: Colors.transparent,
          title: Text(
            widget.title.toUpperCase(),
            style: context.textTheme.headlineSmall
                .copyWith(color: ColorName.primary),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3.0),
            child: progress < 100 // Display processing bar
                ? LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(ColorName.primary),
                  )
                : Container(), // Hide processing bar when loaded
          ),
          backgroundColor: ColorName.background,
        ),
        backgroundColor: ColorName.background,
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}

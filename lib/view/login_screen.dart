import 'package:azureb2cflutter/azureb2c_config.dart';
import 'package:azureb2cflutter/model/azure_token_response.dart';
import 'package:azureb2cflutter/view_model/azure_b2c_client.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => InitScreenState();
}

class InitScreenState extends State<LoginScreen> {
  WebViewController? controller;
  Widget? loadingReplacement;
  bool isLoading = true;
  bool isConnected = false;
  final scope = AzureB2cConfig.scopes;

  String? extractTokenFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String? code = uri.queryParameters['code'];
    return code;
  }

  @override
  void initState() {
    super.initState();

    String concatinatedScope = AzureB2cConfig().scopesToString(
      AzureB2cConfig.scopes,
    );
    final url = Uri.parse(
      '${AzureB2cConfig.authorizationEndpoint}?client_id=${AzureB2cConfig.clientId}&redirect_uri=${AzureB2cConfig.redirectURL}&response_type=${AzureB2cConfig.responseType}&scope=$concatinatedScope',
    );

    AzureB2cClient azureB2cClient = AzureB2cClient();
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.grey)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) async {},
          onUrlChange: (urlChange) async {
            if (urlChange.url!.startsWith(AzureB2cConfig.redirectURL)) {
              setState(() {
                isLoading = true;
              });
              String? code = extractTokenFromUrl(urlChange.url!);
              AzureTokenResponse? azureTokenResponse =
                  await azureB2cClient.exchangeIdTokenForAccessToken(code!);
              if (azureTokenResponse != null) {
                setState(() {
                  isLoading = false;
                });
                // navigate to home page
              }
            } else {
              setState(() {
                isLoading = false;
              });
            }
          },
          onPageFinished: (String url) async {},
        ),
      )
      ..loadRequest(url);

    controller = webViewController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                WebViewWidget(
                  controller: controller!,
                ),
                Visibility(
                  visible: loadingReplacement != null && (isLoading),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child:
                        Center(child: loadingReplacement ?? const SizedBox()),
                  ),
                ),
                Visibility(
                  visible: loadingReplacement == null && isLoading,
                  child: const Center(
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

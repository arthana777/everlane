import 'package:everlane/checkout/paypal_success.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  const WebviewScreen({super.key, required this.approvalUrl});
  final String approvalUrl;

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // You can use this to show a loading indicator.
          },
          onPageStarted: (String url) {
            // You can use this to show a loading indicator.
          },
          onPageFinished: (String url) {
            // You can use this to hide a loading indicator.
          },
          onHttpError: (HttpResponseError error) {
            // Handle HTTP error if needed.
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource error if needed.
          },
          onNavigationRequest: (NavigationRequest request) {
            final uri = Uri.parse(request.url);

              final queryParameters = uri.queryParameters;
              final paymentId = queryParameters['paymentId'];
              final payerId = queryParameters['PayerID'];
              final token = queryParameters['token'];
            if (paymentId != null && payerId != null && token != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessScreen(
                    paymentId: paymentId,
                    payerId: payerId,
                    token: token,
                  ),
                ),
              );
            }
            // Check if the URL matches the approval URL
            // if (request.url.startsWith(approvalUrl)) {
            //   final uri = Uri.parse(request.url);
            //
            //   final queryParameters = uri.queryParameters;
            //   final paymentId = queryParameters['paymentId'];
            //   final payerId = queryParameters['PayerID'];
            //   final token = queryParameters['token'];
            //
            //   if (paymentId != null && payerId != null && token != null) {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => SuccessScreen(
            //           paymentId: paymentId,
            //           payerId: payerId,
            //           token: token,
            //         ),
            //       ),
            //     );
            //   }
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(approvalUrl));

    return Scaffold(
      appBar: AppBar(title: const Text('PAYMENT')),
      body: WebViewWidget(controller: controller),
    );
  }
}

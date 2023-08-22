import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/ui/widgets/payment/payment_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapWebViewScreen extends StatefulWidget {
  final String url;
  const SnapWebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<SnapWebViewScreen> createState() => _SnapWidgetState();
}

class _SnapWidgetState extends State<SnapWebViewScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (url.contains('status_code=202&transaction_status=deny')) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const PaymentScreen(
                  type: DialogType.error,
                  title: "Pembayaran Gagal",
                  desc: "Pembayaran Gagal, Silakan Coba Lagi Terima Kasih!",
                  color: Colors.red,
                );
              }));
            }
            if (url.contains('status_code=200&transaction_status=settlement')) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const PaymentScreen(
                  type: DialogType.success,
                  title: "Pembayaran Success",
                  desc: "Selamat Pembayaran Berhasil dilakukan",
                  color: Colors.green,
                );
              }));
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'qr_code_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Generator',
      theme: ThemeData.dark(),
      home: QrCodeGeneratorScreen(),
    );
  }
}

class QrCodeGeneratorScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrCodeData = ref.watch(qrCodeDataProvider);
    final textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter data for QR Code',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(qrCodeDataProvider.notifier).state =
                    textEditingController.text;
              },
              child: Text('Generate QR Code'),
            ),
            SizedBox(height: 16),
            if (qrCodeData.isNotEmpty)
              Expanded(
                child: PrettyQrView.data(
                  data: qrCodeData,
                  decoration: PrettyQrDecoration(
                    shape: PrettyQrSmoothSymbol(
                      color: Colors.white,
                    ),
                    // image: PrettyQrDecorationImage(
                    //   image: AssetImage('assets/images/help.png'),
                    // ),
                  ),
                ),
              )
            // QrImageView(
            //   version: QrVersions.auto,
            //   data: qrCodeData,
            //   size: 200.0,
            // ),
          ],
        ),
      ),
    );
  }
}

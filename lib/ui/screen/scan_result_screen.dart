import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ScanResultScreen extends StatelessWidget {
  final String result;

  ScanResultScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SelectableText(
              result,
              style: const TextStyle(fontSize: 18, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.go("/");
                  },
                  child: const Text('Home'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: result));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Copied to Clipboard!'),
                      ),
                    );
                  },
                  child: const Text('Copy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

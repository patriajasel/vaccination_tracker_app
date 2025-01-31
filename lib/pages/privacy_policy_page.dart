import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';

class PrivacyPolicyPage extends ConsumerWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(navIndicatorProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text('Privacy Policy'),
      ),
      body: SfPdfViewer.asset(
        'lib/assets/files/PrivacyPolicy.pdf',
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'stream_pdf_view_platform_interface.dart';

/// An implementation of [StreamPdfViewPlatform] that uses method channels.
class MethodChannelStreamPdfView extends StreamPdfViewPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('stream_pdf_view');

  @override
  Future<void> openPdf(String url) async {
    await methodChannel.invokeMethod('openPdf', url);
  }
}

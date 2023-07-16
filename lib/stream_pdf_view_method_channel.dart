import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'stream_pdf_view_platform_interface.dart';

/// An implementation of [StreamPdfViewPlatform] that uses method channels.
class MethodChannelStreamPdfView implements StreamPdfViewPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('stream_pdf_view');

  @override
  Future<void> openPdf(String url) async {
    await methodChannel.invokeMethod('openPdf', url);
  }

  @override
  Future<int?> currentPage() async {
    return await methodChannel.invokeMethod('currentPage');
  }

  @override
  Future<int?> pageCount() async {
    return await methodChannel.invokeMethod('countPage');

  }

  @override
  Future<void> jumpTo(int to) async{
    return await methodChannel.invokeMethod('jumpTo', to);

  }
}

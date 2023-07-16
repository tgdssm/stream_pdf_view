import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'stream_pdf_view_method_channel.dart';

abstract class StreamPdfViewPlatform extends PlatformInterface {
  /// Constructs a StreamPdfViewPlatform.
  StreamPdfViewPlatform() : super(token: _token);

  static final Object _token = Object();

  static StreamPdfViewPlatform _instance = MethodChannelStreamPdfView();

  /// The default instance of [StreamPdfViewPlatform] to use.
  ///
  /// Defaults to [MethodChannelStreamPdfView].
  static StreamPdfViewPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StreamPdfViewPlatform] when
  /// they register themselves.
  static set instance(StreamPdfViewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }


  Future<void> openPdf(String url) {
    throw UnimplementedError('openPdf() has not been implemented.');
  }

  Future<int?> currentPage() {
    throw UnimplementedError('currentPage() has not been implemented.');
  }

  Future<int?> pageCount() {
    throw UnimplementedError('pageCount() has not been implemented.');
  }

  Future<void> jumpTo(int to) {
    throw UnimplementedError('jumpTo() has not been implemented.');
  }
}

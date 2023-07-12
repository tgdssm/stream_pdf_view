import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pdf_view/stream_pdf_view_platform_interface.dart';
import 'package:stream_pdf_view/stream_pdf_view_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockStreamPdfViewPlatform
    with MockPlatformInterfaceMixin
    implements StreamPdfViewPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> openPdf(String url) {
    // TODO: implement openPdf
    throw UnimplementedError();
  }
}

void main() {
  final StreamPdfViewPlatform initialPlatform = StreamPdfViewPlatform.instance;

  test('$MethodChannelStreamPdfView is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStreamPdfView>());
  });

  // test('getPlatformVersion', () async {
  //   StreamPdfView streamPdfViewPlugin = StreamPdfView();
  //   MockStreamPdfViewPlatform fakePlatform = MockStreamPdfViewPlatform();
  //   StreamPdfViewPlatform.instance = fakePlatform;
  //
  //   // expect(await streamPdfViewPlugin.getPlatformVersion(), '42');
  // });
}

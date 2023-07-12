import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pdf_view/stream_pdf_view_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelStreamPdfView platform = MethodChannelStreamPdfView();
  const MethodChannel channel = MethodChannel('stream_pdf_view');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

}

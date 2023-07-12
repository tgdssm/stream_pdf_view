
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class _StreamPdfView {
  final methodChannel = const MethodChannel('stream_pdf_view');

  Future<void> openPdf(String url) async {
    await methodChannel.invokeMethod('openPdf', url);
  }
}

class StreamPDFViewWidget extends StatefulWidget {
  final String url;
  const StreamPDFViewWidget({super.key, required this.url});

  @override
  State<StreamPDFViewWidget> createState() => _StreamPDFViewWidgetState();
}

class _StreamPDFViewWidgetState extends State<StreamPDFViewWidget> {
  final _streamPdfViewPlugin = _StreamPdfView();
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _streamPdfViewPlugin.openPdf(widget.url);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const AndroidView(
      viewType: "stream_pdf_view",
      layoutDirection: TextDirection.ltr,
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}


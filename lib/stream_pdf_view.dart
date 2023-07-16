import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_pdf_view/stream_pdf_view_method_channel.dart';

class _StreamPdfView {
  final methodChannel = MethodChannelStreamPdfView();

  Future<void> openPdf(String url) async {
    await methodChannel.openPdf(url);
  }

  Future<int?> currentPage() async {
    return await methodChannel.currentPage();
  }

  Future<int?> pageCount() async {
    return await methodChannel.pageCount();
  }

  Future<void> jumpTo(int to) async {
    await methodChannel.jumpTo(to);
  }
}

class StreamPDFViewWidget extends StatefulWidget {
  final String url;
  final void Function(int, int) onChangedPage;
  final int? jumpTo;
  const StreamPDFViewWidget({
    super.key,
    required this.url,
    required this.onChangedPage,
    this.jumpTo,
  });

  @override
  State<StreamPDFViewWidget> createState() => _StreamPDFViewWidgetState();
}

class _StreamPDFViewWidgetState extends State<StreamPDFViewWidget> {
  final _streamPdfViewPlugin = _StreamPdfView();
  final controller = ViewController();

  @override
  void didUpdateWidget(covariant StreamPDFViewWidget oldWidget) {
    controller.widget = widget;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AndroidView(
            viewType: 'stream_pdf_view',
            onPlatformViewCreated: (id) {
              _streamPdfViewPlugin.openPdf(widget.url).then((value) {
                if (widget.jumpTo != null) {
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () async {
                      await _streamPdfViewPlugin.jumpTo(widget.jumpTo!);
                    },
                  );
                }
              });
            },
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, widget) {
              return Slider(
                value: controller.sliderValue,
                onChanged: (value) async {
                  controller.currentPage = (controller.pageCount * value).toInt();
                  await _streamPdfViewPlugin.jumpTo(controller.currentPage);
                },
              );
            }
          ),
        )
      ],
    );
  }
}

class ViewController extends ChangeNotifier{
  late final MethodChannel channel;
  StreamPDFViewWidget? widget;
  int currentPage = 0;
  int pageCount = 0;
  double sliderValue = 0;
  ViewController() {
    channel = const MethodChannel('stream_pdf_view');
    channel.setMethodCallHandler(onMethodCall);
  }

  Future<void> onMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onPageChanged':
        currentPage = call.arguments['page'];
        pageCount = call.arguments['pageCount'];
        widget?.onChangedPage(
          currentPage,
          pageCount,
        );
        getValue();
        notifyListeners();
        break;
      default:
        // print(call.arguments);
        break;
    }
  }

  void getValue() {
    if (currentPage == 0 || pageCount == 0) {
      sliderValue = 0;
    }
    sliderValue = currentPage / pageCount;
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:stream_pdf_view/stream_pdf_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const StreamPDFViewWidget(
          url: 'https://biblioteca.incaper.es.gov.br/digital/bitstream/item/105/1/MINICURSO-CD-6-RECOMENDACOES-TECNICAS-PARA-MANGA.pdf',
        ),
      ),
    );
  }
}

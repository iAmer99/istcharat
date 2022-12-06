import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  final pdfUrl;
  const PdfScreen({Key? key, @required this.pdfUrl}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.pdfUrl);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SfPdfViewer.network(widget.pdfUrl,
                enableDoubleTapZooming: true),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfViewer extends StatefulWidget {
  final String file;
  pdfViewer({Key? key, required this.file}) : super(key: key);

  @override
  State<pdfViewer> createState() => _pdfViewerState(this.file);
}

class _pdfViewerState extends State<pdfViewer> {
  _pdfViewerState(this.file);

  final String file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content EduCourse'),
      ),
      body: SfPdfViewer.network(
        file,
      ),
    );
  }
}

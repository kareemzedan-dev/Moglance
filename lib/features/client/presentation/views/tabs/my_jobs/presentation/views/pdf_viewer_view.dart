import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';

class FileViewerView extends StatelessWidget {
  final String filePath;
  final bool isNetwork;

  const FileViewerView({
    super.key,
    required this.filePath,
    this.isNetwork = false,
  });

  bool get isPdf => filePath.toLowerCase().endsWith('.pdf');
  bool get isImage =>
      filePath.toLowerCase().endsWith('.png') ||
          filePath.toLowerCase().endsWith('.jpg') ||
          filePath.toLowerCase().endsWith('.jpeg') ||
          filePath.toLowerCase().endsWith('.gif');

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          local.file_viewer,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Builder(
            builder: (context) {
              if (isPdf) {
                return isNetwork
                    ? SfPdfViewer.network(filePath)
                    : SfPdfViewer.file(File(filePath));
              } else if (isImage) {
                return isNetwork
                    ? Image.network(filePath, fit: BoxFit.contain)
                    : Image.file(File(filePath), fit: BoxFit.contain);
              } else {
                return Center(
                  child: Text(
                    'Cannot preview this file type',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

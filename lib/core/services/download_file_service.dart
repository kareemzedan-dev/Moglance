import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  final Dio dio;

  DownloadService(this.dio);


  Future<File> downloadFile(String url, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final savePath = "${dir.path}/$fileName";

    await dio.download(url, savePath);

    return File(savePath);
  }
}

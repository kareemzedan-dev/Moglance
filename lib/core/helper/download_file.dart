import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<File> downloadFile(String url) async {
  final response = await http.get(Uri.parse(url));
  final dir = await getTemporaryDirectory();
  final fileName = basename(url);
  final file = File('${dir.path}/$fileName');
  return await file.writeAsBytes(response.bodyBytes);
}

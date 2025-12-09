import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
@singleton
class FilePickerService {
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return null;
    return File(result.files.first.path!);
  }

  Future<List<File>?> pickMultipleFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null || result.files.isEmpty) return null;
    return result.paths.map((path) => File(path!)).toList();
  }
}

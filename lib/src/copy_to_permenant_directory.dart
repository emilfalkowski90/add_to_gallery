import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

var _uuid = Uuid();

/// Copies the file to the Application Documents Directory
///
/// This means that any temporary files are persisted
Future<File> copyToPermanentDirectory({
  required File originalFile,
  required String prefix,
  required bool keepOriginalFileName,
}) async {
  String fileName;
  if (keepOriginalFileName) {
    fileName = basename(originalFile.path);
  } else {
    String fileExt = extension(originalFile.path);
    fileName = '$prefix-${_uuid.v4()}$fileExt'; // image-UNIQUEID.jpg
  }
  Directory directory = await getApplicationDocumentsDirectory();
  return await originalFile.copy('${directory.path}/$fileName');
}

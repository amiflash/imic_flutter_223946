import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
//Declare static variable
  FileManager._privateConstructor();
  static final FileManager _instance = FileManager._privateConstructor();
  static FileManager get instance => _instance;

  String photoPath = 'photos';

  Future<Directory> getPhotoDirectory() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    String appDocPath = appDocDir.path;

    String relativePath = "$appDocPath/$photoPath";

    bool directoryExisting = await Directory(relativePath).exists();

    if (!directoryExisting) {
      await Directory(relativePath).create(recursive: true);
    }

    return Directory(relativePath);
  }

  Future<File> saveImage(File imageFile, String imageName) async {
    Directory photoDirectory = await getPhotoDirectory();
    String imagePath = '${photoDirectory.path}/$imageName';

    Directory imageURL = Directory(imagePath);

    bool existing = await imageURL.exists();

    if (existing) {
      await imageURL.delete();
    }

    return imageFile.copy(imagePath);
  }

  Future<File?> retrieveImage(String imageName) async {
    Directory photoDirectory = await getPhotoDirectory();
    String imagePath = '${photoDirectory.path}/$imageName';

    bool existing = await Directory(imagePath).exists();

    if (existing) {
      return null;
    }

    return File(imagePath);
  }
}

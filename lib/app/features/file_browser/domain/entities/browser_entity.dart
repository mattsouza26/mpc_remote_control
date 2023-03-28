// ignore_for_file: public_member_api_docs, sort_constructors_first

class BrowserEntity {
  final String path;
  final List<FileEntity> files;
  const BrowserEntity({
    required this.path,
    required this.files,
  });
}

enum FileType {
  directory("Directory"),
  video("Video"),
  image("Image"),
  unsupported("Unsupported");

  final String type;
  const FileType(this.type);

  static FileType getFileType(String type) {
    switch (type) {
      case 'Directory':
        return FileType.directory;
      case 'AVI':
      case 'MP4':
      case 'Matroska':
        return FileType.video;
      case 'pngfile':
      case 'jpegfile':
        return FileType.image;
      default:
        return FileType.unsupported;
    }
  }

  @override
  String toString() => type;
}

class FileEntity {
  final String name;
  final String path;
  final FileType type;
  const FileEntity({
    required this.name,
    required this.path,
    required this.type,
  });
}

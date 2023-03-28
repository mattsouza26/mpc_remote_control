import '../../domain/entities/browser_entity.dart';

class BrowserDTO extends BrowserEntity {
  BrowserDTO({
    required super.path,
    required super.files,
  });
}

class FileDTO extends FileEntity {
  FileDTO({
    required super.name,
    required super.path,
    required super.type,
  });

  factory FileDTO.fromMap(Map<String, dynamic> map) {
    return FileDTO(
      name: map['name'],
      path: map['path'],
      type: map['type'],
    );
  }
}

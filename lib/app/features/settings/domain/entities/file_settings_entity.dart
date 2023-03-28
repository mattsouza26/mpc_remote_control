// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class FileSettingsEntity {
  final bool unsupportedFiles;
  final bool fileExtension;
  final bool fullFileName;
  const FileSettingsEntity({
    required this.unsupportedFiles,
    required this.fileExtension,
    required this.fullFileName,
  });
}

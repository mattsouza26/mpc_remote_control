import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../entities/browser_entity.dart';
import '../errors/file_browser_failure.dart';
import '../repositories/browser_repository.dart';

abstract class OpenFolderUseCase {
  Future<Result<BrowserEntity, FileBrowserFailure>> call(Server server, String path);
}

class OpenFolderUseCaseImpl implements OpenFolderUseCase {
  final BrowserRepository _repository;

  OpenFolderUseCaseImpl(this._repository);
  @override
  Future<Result<BrowserEntity, FileBrowserFailure>> call(Server server, String path) {
    return _repository.openFolder(server, path);
  }
}

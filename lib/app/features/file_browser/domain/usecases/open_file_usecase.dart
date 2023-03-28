import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../errors/file_browser_failure.dart';
import '../repositories/browser_repository.dart';

abstract class OpenFileUseCase {
  Future<Result<void, FileBrowserFailure>> call(Server server, String path);
}

class OpenFileUseCaseImpl implements OpenFileUseCase {
  final BrowserRepository _repository;

  OpenFileUseCaseImpl(this._repository);
  @override
  Future<Result<void, FileBrowserFailure>> call(Server server, String path) {
    return _repository.openFile(server, path);
  }
}

import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../../domain/errors/file_browser_failure.dart';
import '../../domain/usecases/get_files_usecase.dart';
import '../../domain/usecases/open_file_usecase.dart';
import '../../domain/usecases/open_folder_usecase.dart';
import '../models/browser_model.dart';

class FileBrowserRepository {
  final GetFilesUseCase _getFilesUseCase;
  final OpenFolderUseCase _openFolderUseCase;
  final OpenFileUseCase _openFileUseCase;

  FileBrowserRepository(
    this._getFilesUseCase,
    this._openFolderUseCase,
    this._openFileUseCase,
  );

  BrowserModel? _browser;

  Future<Result<BrowserModel, FileBrowserFailure>> getFiles(Server server) async {
    final result = await _getFilesUseCase(server);
    return result.fold(
      (browser) {
        _browser = BrowserModel(
          path: browser.path,
          files: browser.files,
        );
        return Success(_browser!);
      },
      (failure) => Failure(FileBrowserFailure(failure.message)),
    );
  }

  Future<Result<void, FileBrowserFailure>> openFile(Server server, String path) async {
    final result = await _openFileUseCase(server, path);
    return result.fold(
      (browser) {
        return const Success(Unit);
      },
      (failure) => Failure(FileBrowserFailure(failure.message)),
    );
  }

  Future<Result<BrowserModel, FileBrowserFailure>> openFolder(Server server, String path) async {
    final result = await _openFolderUseCase(server, path);
    return result.fold(
      (browser) {
        _browser = BrowserModel(
          path: browser.path,
          files: browser.files,
        );
        return Success(_browser!);
      },
      (failure) => Failure(FileBrowserFailure(failure.message)),
    );
  }

  Future<Result<BrowserModel, FileBrowserFailure>> searchFiles(Server server, String text) async {
    if (_browser == null) return const Failure(FileBrowserFailure('Server may not be online.'));
    final searchedFiles = _browser!.files.where((file) => file.name.toLowerCase().contains(text)).toList();
    final newBrowser = BrowserModel(path: _browser!.path, files: searchedFiles);
    return Success(newBrowser);
  }
}

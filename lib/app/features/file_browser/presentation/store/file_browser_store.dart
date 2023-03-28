// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import '../../../../core/models/server.dart';
import '../repository/file_browser_repository.dart';
import '../state/file_browser_state.dart';

class FileBrowserStore extends ValueNotifier<FileBrowserState> {
  final FileBrowserRepository _repository;
  FileBrowserStore(
    this._repository,
  ) : super(FileBrowserLoadingState());

  _emit(FileBrowserState state) {
    value = state;
  }

  Future<void> getFiles(Server? server) async {
    _emit(FileBrowserLoadingState());
    if (server == null) return _emit(FileBrowserErrorState());

    final result = await _repository.getFiles(server);
    result.fold(
      (success) => _emit(FileBrowserLoadedState(success)),
      (failure) => _emit(FileBrowserErrorState()),
    );
  }

  Future<void> openFile(Server? server, String path) async {
    if (server == null) return _emit(FileBrowserErrorState());
    final result = await _repository.openFile(server, path);
    if (result.isSuccess()) return;

    _emit(FileBrowserErrorState());
  }

  Future<void> searchFiles(Server? server, String text) async {
    _emit(FileBrowserLoadingState());
    if (server == null) return _emit(FileBrowserErrorState());

    final result = await _repository.searchFiles(server, text);
    result.fold(
      (success) => _emit(FileBrowserLoadedState(success)),
      (failure) => _emit(FileBrowserErrorState()),
    );
  }

  Future<void> openFolder(Server? server, String path) async {
    _emit(FileBrowserLoadingState());
    if (server == null) return _emit(FileBrowserErrorState());

    final result = await _repository.openFolder(server, path);
    result.fold(
      (success) => _emit(FileBrowserLoadedState(success)),
      (failure) => _emit(FileBrowserErrorState()),
    );
  }
}

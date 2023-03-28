import '../models/browser_model.dart';

abstract class FileBrowserState {}

class FileBrowserLoadingState extends FileBrowserState {}

class FileBrowserErrorState extends FileBrowserState {}

class FileBrowserLoadedState extends FileBrowserState {
  final BrowserModel browser;

  FileBrowserLoadedState(this.browser);
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/widgets/slide_animated_text/slide_animated_text.dart';
import '../../../../server/presentation/controller/server_controller.dart';
import '../../../../settings/presentation/controller/settings_controller.dart';
import '../../../domain/entities/browser_entity.dart';
import '../../state/file_browser_state.dart';
import '../../store/file_browser_store.dart';
import 'widgets/browser_file_item.dart';
import 'widgets/error_file_browser.dart';
import 'widgets/file_browser_app_bar.dart';

class FileBrowserScreen extends StatefulWidget {
  const FileBrowserScreen({super.key});

  @override
  State<FileBrowserScreen> createState() => _FileBrowserScreenState();
}

class _FileBrowserScreenState extends State<FileBrowserScreen> {
  late final FileBrowserStore _store;
  late final ServerController _serverController;
  late final bool _showUnsupportedFiles;
  late final bool _showFileExtension;
  late final bool _showFullFileName;

  @override
  void initState() {
    _store = GetIt.instance.get<FileBrowserStore>();
    _serverController = GetIt.instance.get<ServerController>();
    final SettingsController settingsController = GetIt.instance.get<SettingsController>();

    _showUnsupportedFiles = settingsController.unsupportedFiles.value;
    _showFileExtension = settingsController.fileExtension.value;
    _showFullFileName = settingsController.fullFileName.value;

    _serverController.selected.mediaStatus?.fileName.addListener(_selectedFileChange);
    _store.getFiles(_serverController.selected.server);
    super.initState();
  }

  @override
  void dispose() {
    _serverController.selected.mediaStatus?.fileName.removeListener(_selectedFileChange);
    super.dispose();
  }

  void _selectedFileChange() {
    setState(() {});
  }

  void _open(FileEntity file) {
    if (file.type == FileType.directory) {
      _store.openFolder(_serverController.selected.server, file.path);
    } else {
      _store.openFile(_serverController.selected.server, file.path);
    }
  }

  void _searchFiles(String text) {
    _store.searchFiles(_serverController.selected.server, text);
  }

  void _onReload(String path) {
    _store.openFolder(_serverController.selected.server, path);
  }

  void _onBackHome() {
    _store.getFiles(_serverController.selected.server);
  }

  bool _isFileSelected(String fileName) {
    return fileName == _serverController.selected.mediaStatus?.fileName.value;
  }

  List<FileEntity> _hideUnsupportedFiles(List<FileEntity> list) {
    return !_showUnsupportedFiles //
        ? list.where((element) => element.type != FileType.unsupported).toList()
        : list;
  }

  String _hideFileExtension(String fileName) {
    if (fileName != '..' && !_showFileExtension) {
      int dotIndex = fileName.lastIndexOf('.');
      if (dotIndex == -1) return fileName;
      return fileName.substring(0, dotIndex);
    }
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _store,
        builder: (context, state, child) {
          final String currentPath = state is FileBrowserLoadedState ? state.browser.path : "";
          final List<FileEntity> files = state is FileBrowserLoadedState ? _hideUnsupportedFiles(state.browser.files) : [];
          return CustomScrollView(
            scrollBehavior: const MaterialScrollBehavior().copyWith(overscroll: false),
            physics: state is FileBrowserLoadedState ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
            slivers: [
              FileBrowserAppBar(
                onBackHome: _onBackHome,
                onReload: () => _onReload(currentPath),
                onSearching: _searchFiles,
                flexibleSpace: Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  visible: currentPath.isNotEmpty,
                  child: SlideAnimatedText(
                    text: currentPath,
                    style: Theme.of(context).textTheme.titleLarge,
                    blankSpace: 50,
                    startAfter: const Duration(seconds: 3),
                    pauseAfterRound: const Duration(seconds: 5),
                  ),
                ),
              ),
              if (state is FileBrowserLoadingState) const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              if (state is FileBrowserErrorState) const SliverFillRemaining(child: ErrorFileBrowser()),
              if (state is FileBrowserLoadedState)
                SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: files.length, (context, index) {
                    final file = files[index];
                    return BrowserFileWidget(
                      fullFileName: _showFullFileName,
                      fileName: _hideFileExtension(file.name),
                      fileType: file.type,
                      isSelected: _isFileSelected(file.name),
                      onTap: () => _open(file),
                    );
                  }),
                ),
            ],
          );
        },
      ),
    );
  }
}

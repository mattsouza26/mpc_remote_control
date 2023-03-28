import 'package:flutter/material.dart';

import '../../../../domain/entities/browser_entity.dart';

class BrowserFileWidget extends StatelessWidget {
  final String fileName;
  final FileType fileType;
  final bool isSelected;
  final void Function()? onTap;
  final bool fullFileName;
  const BrowserFileWidget({
    super.key,
    required this.fileName,
    required this.fileType,
    required this.isSelected,
    this.onTap,
    required this.fullFileName,
  });

  Widget getIcon(FileType type) {
    Widget? icon;
    switch (type) {
      case FileType.directory:
        icon = const Icon(
          Icons.folder,
          size: 32,
        );
        break;
      case FileType.video:
        icon = const Icon(
          Icons.movie_rounded,
          size: 32,
        );
        break;
      case FileType.image:
      case FileType.unsupported:
        icon = const Icon(
          Icons.file_copy_sharp,
          size: 32,
        );
        break;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: ListTile(
        selected: isSelected,
        dense: true,
        leading: getIcon(fileType),
        title: Text(
          fileName,
          style: const TextStyle(
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: fullFileName ? 2 : 1,
        ),
        onTap: onTap,
      ),
    );
  }
}

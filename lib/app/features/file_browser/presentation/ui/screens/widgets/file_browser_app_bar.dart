import 'package:flutter/material.dart';

import '../../../../../../core/utils/screen_utils.dart';

class FileBrowserAppBar extends StatefulWidget {
  final Widget flexibleSpace;
  final Function() onBackHome;
  final Function() onReload;
  final Function(String) onSearching;
  const FileBrowserAppBar({super.key, required this.flexibleSpace, required this.onSearching, required this.onBackHome, required this.onReload});

  @override
  State<FileBrowserAppBar> createState() => _FileBrowserAppBarState();
}

class _FileBrowserAppBarState extends State<FileBrowserAppBar> {
  bool _isSearching = false;

  void _startSearching() {
    setState(() {
      _isSearching = true;
    });
  }

  void _onSearching(String value) {
    widget.onSearching.call(value);
  }

  void _cancelSearchingOrGoingBack() {
    if (_isSearching) {
      setState(() {
        _isSearching = false;
        widget.onSearching.call("");
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
        onPressed: _cancelSearchingOrGoingBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      title: !_isSearching
          ? Text(
              'File Browser',
              style: Theme.of(context).textTheme.titleLarge!,
            )
          : TextField(
              onChanged: _onSearching,
              decoration: const InputDecoration(
                constraints: BoxConstraints(maxHeight: 50),
                alignLabelWithHint: true,
                label: Icon(Icons.search),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
      expandedHeight: ScreenUtils().appBarAndStatusBarHeight(context) + 30,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(top: ScreenUtils().appBarAndStatusBarHeight(context)),
          child: widget.flexibleSpace,
        ),
      ),
      pinned: true,
      floating: true,
      stretch: true,
      actions: [
        if (!_isSearching)
          IconButton(
            onPressed: _startSearching,
            icon: const Icon(Icons.search_sharp),
          ),
        PopupMenuButton(
          position: PopupMenuPosition.under,
          itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
            PopupMenuItem(
              onTap: widget.onBackHome,
              child: Row(
                children: const [
                  Icon(Icons.home),
                  SizedBox(width: 5),
                  Text("Back Home"),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: widget.onReload,
              child: Row(
                children: const [
                  Icon(Icons.refresh),
                  SizedBox(width: 5),
                  Text("Reload"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

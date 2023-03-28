import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/models/server.dart';
import '../../../../server/presentation/controller/server_controller.dart';
import '../../../../settings/presentation/controller/settings_controller.dart';
import '../../models/manage_server_model.dart';
import '../../state/manage_servers_state.dart';
import '../../store/manage_servers_store.dart';
import '../dialog/manage_server_details_dialog.dart';
import 'widgets/discover_loading.dart';
import 'widgets/empty_manage_servers.dart';
import 'widgets/error_manage_servers.dart';
import 'widgets/manage_server_item.dart';

class ManageServersScreen extends StatefulWidget {
  const ManageServersScreen({super.key});

  @override
  State<ManageServersScreen> createState() => _ManageServersScreenState();
}

class _ManageServersScreenState extends State<ManageServersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late final ManageServersStore _store;
  late final ServerController _serverController;
  late final SettingsController _settingsController;
  @override
  void initState() {
    _store = GetIt.instance.get<ManageServersStore>();
    _serverController = GetIt.instance.get<ServerController>();
    _settingsController = GetIt.instance.get<SettingsController>();

    _serverController.addListener(_updateSelectedServer);

    _discover();
    super.initState();
  }

  @override
  void dispose() {
    _serverController.removeListener(_updateSelectedServer);
    super.dispose();
  }

  void _updateSelectedServer() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  Future<void> _updateManageServerItem([ManageServerModel? manageServer, bool? isEditing]) async {
    final editedManageServer = await showDialog(
      context: context,
      builder: (context) {
        return ManageServerDetailsDialog(manageServer: manageServer);
      },
    );
    if (editedManageServer == null) return;
    if (isEditing == null || isEditing == false) {
      _store.add(editedManageServer).then((response) async {
        if (response.error == true) {
          await _showSnackBarError(response.message.toString());
          _updateManageServerItem(editedManageServer);
        }
      });
    } else {
      _store.edit(editedManageServer).then((response) async {
        if (response.error == true) {
          await _showSnackBarError(response.message.toString());
          _updateManageServerItem(editedManageServer, true);
        }
      });
    }
  }

  Future<void> _showSnackBarError(String message) async {
    ScaffoldMessenger.of(_scaffoldkey.currentContext!).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
    ));
    await Future.delayed(const Duration(milliseconds: 1500));
    ScaffoldMessenger.of(_scaffoldkey.currentContext!).removeCurrentSnackBar();
    await Future.delayed(const Duration(milliseconds: 50));
  }

  void _connectServer(Server server) {
    _serverController.selectServer(server).then(
          (value) => ScaffoldMessenger.of(_scaffoldkey.currentContext!).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Server: ${server.toAddress()} Selected'),
            ),
          ),
        );
  }

  void _disconnect() {
    _serverController.disconnect().then(
          (value) => ScaffoldMessenger.of(_scaffoldkey.currentContext!).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Server Disconnected'),
            ),
          ),
        );
  }

  void _deleteManageServerItem(ManageServerModel manageServer) {
    _store.delete(manageServer);
  }

  bool _isConnected(ManageServerModel manageServer) {
    return manageServer.server == _serverController.selected.server;
  }

  Future<void> _discover() async {
    _store.discover(_settingsController.subnet.value, [13579, 13578, 3000]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Server Management',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        actions: [
          IconButton(
            highlightColor: Colors.transparent,
            padding: const EdgeInsets.only(right: 15),
            onPressed: _discover,
            icon: const Icon(Icons.settings_input_antenna_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateManageServerItem();
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
          valueListenable: _store,
          builder: (context, state, child) {
            if (state is ManageServersLoadingState) {
              return const DiscoverLoading();
            }
            if (state is ManageServersEmptyState) {
              return const EmptyManageServers();
            }
            if (state is ManageServersLoadedState) {
              final servers = state.servers;

              return ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: servers.length,
                itemBuilder: (context, index) {
                  final ManageServerModel manageServer = servers[index];
                  return ManageServerItem(
                    manageServer: manageServer,
                    isSelected: _isConnected(manageServer),
                    onConnect: () => _connectServer(manageServer.server),
                    onDisconnect: () => _disconnect(),
                    onDelete: () => _deleteManageServerItem(manageServer),
                    onEdit: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _updateManageServerItem(manageServer, true);
                      });
                    },
                  );
                },
              );
            }

            if (state is ManageServersErrorState) {
              return const ErrorManageServers();
            }
            return const SizedBox.shrink();
          }),
    );
  }
}

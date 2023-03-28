import 'package:collection/collection.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/usecases/delete_manage_server_usecase.dart';
import '../../domain/usecases/discover_servers_usecase.dart';
import '../../domain/usecases/edit_manage_server_usecase.dart';
import '../../domain/usecases/load_manage_servers_usecase.dart';
import '../../domain/usecases/save_manage_server_usecase.dart';
import '../../domain/errors/manage_servers_failure.dart';
import '../models/manage_server_model.dart';

class ManageServersRepository {
  final LoadManageServersUseCase _loadManageServersUseCase;
  final SaveManageServerUseCase _saveManageServerUseCase;
  final EditManageServerUseCase _editManageServerUseCase;
  final DeleteManageServerUseCase _deleteManageServerUseCase;
  final DiscoverServerUseCase _discoverServerUseCase;

  ManageServersRepository(
    this._loadManageServersUseCase,
    this._saveManageServerUseCase,
    this._editManageServerUseCase,
    this._deleteManageServerUseCase,
    this._discoverServerUseCase,
  ) {
    _init();
  }
  final List<ManageServerModel> _servers = [];

  Future<List<ManageServerModel>> init() async {
    return _servers;
  }

  Future<void> _init() async {
    final result = await _loadManageServersUseCase();
    final servers = result.getOrNull();
    if (servers == null) return;
    for (var manageServer in servers) {
      _servers.add(ManageServerModel(id: manageServer.id, name: manageServer.name, server: manageServer.server));
    }
  }

  Future<Result<List<ManageServerModel>, ManageServersFailure>> discoverServers(String subnet, List<int> ports) async {
    final result = await _discoverServerUseCase(subnet, ports);
    return result.fold((discoveredServers) {
      for (var discoveredServer in discoveredServers) {
        final ManageServerModel? serverExist = _servers.firstWhereOrNull((manageServer) => manageServer.server == discoveredServer.server);
        if (serverExist == null) {
          _servers.add(ManageServerModel(id: discoveredServer.id, name: discoveredServer.name, server: discoveredServer.server));
        }
      }
      if (_servers.isEmpty) return Failure(ManageServersFailure("Servers not found"));
      return Success(_servers);
    }, (failure) {
      if (_servers.isEmpty) return Failure(ManageServersFailure("Servers not found"));
      return Success(_servers);
    });
  }

  Future<Result<List<ManageServerModel>, ManageServersFailure>> add(ManageServerModel manageServer) async {
    final ManageServerModel? serverExist = _servers.firstWhereOrNull((server) => server.server == manageServer.server);
    if (serverExist != null) return Failure(ManageServersFailure("Server already exist"));

    final result = await _saveManageServerUseCase(manageServer);
    return result.fold(
      (success) {
        _servers.add(manageServer);
        return Success(_servers);
      },
      (failure) => Failure(ManageServersFailure(failure.message)),
    );
  }

  Future<Result<List<ManageServerModel>, ManageServersFailure>> delete(ManageServerModel manageServer) async {
    final ManageServerModel? serverExist = _servers.firstWhereOrNull((server) => server.id == manageServer.id);
    if (serverExist == null) return Failure(ManageServersFailure("Server doesn't not exist"));

    final result = await _deleteManageServerUseCase(manageServer);
    return result.fold(
      (success) {
        _servers.removeWhere((server) => server == serverExist);
        return Success(_servers);
      },
      (failure) => Failure(ManageServersFailure(failure.message)),
    );
  }

  Future<Result<List<ManageServerModel>, ManageServersFailure>> edit(ManageServerModel manageServer) async {
    final duplicateServer = _servers.firstWhereOrNull((server) => server.server == manageServer.server);
    if (duplicateServer != null && duplicateServer.id != manageServer.id) return Failure(ManageServersFailure("Server already exist"));

    final ManageServerModel? serverExist = _servers.firstWhereOrNull((server) => server.id == manageServer.id);
    if (serverExist == null) return Failure(ManageServersFailure("Server doesn't not exist"));

    final result = await _editManageServerUseCase(manageServer);
    return result.fold(
      (success) {
        _servers[_servers.indexWhere((server) => server == serverExist)] = manageServer;
        return Success(_servers);
      },
      (failure) => Failure(ManageServersFailure(failure.message)),
    );
  }
}

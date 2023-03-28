import 'package:flutter/foundation.dart';

import '../models/manage_server_model.dart';
import '../models/manage_servers_response.dart';
import '../repositories/manage_servers_repository.dart';
import '../state/manage_servers_state.dart';

class ManageServersStore extends ValueNotifier<ManageServersState> {
  final ManageServersRepository _repository;
  ManageServersStore(this._repository) : super(ManageServersLoadingState());
  _emit(ManageServersState state) {
    value = state;
  }

  bool _isDiscovering = false;

  Future<ManageServersResponse> add(ManageServerModel manageServer) async {
    final result = await _repository.add(manageServer);
    return result.fold(
      (success) {
        _emit(ManageServersLoadedState(success));
        return ManageServersResponse("Successfully added");
      },
      (failure) {
        return ManageServersResponse(failure.message, error: true);
      },
    );
  }

  Future<ManageServersResponse> delete(ManageServerModel manageServer) async {
    final result = await _repository.delete(manageServer);
    return result.fold(
      (success) {
        if (success.isEmpty) {
          _emit(ManageServersEmptyState());
        } else {
          _emit(ManageServersLoadedState(success));
        }
        return ManageServersResponse("Successfully delete");
      },
      (failure) {
        return ManageServersResponse(failure.message, error: true);
      },
    );
  }

  Future<ManageServersResponse> edit(ManageServerModel manageServer) async {
    final result = await _repository.edit(manageServer);
    return result.fold(
      (success) {
        _emit(ManageServersLoadedState(success));
        return ManageServersResponse("Successfully edit");
      },
      (failure) {
        return ManageServersResponse(failure.message, error: true);
      },
    );
  }

  Future<void> discover(String subnet, List<int> ports) async {
    if (_isDiscovering == true) return;
    _isDiscovering = true;
    _emit(ManageServersLoadingState());
    final result = await _repository.discoverServers(subnet, ports);

    result.fold(
      (success) {
        _emit(ManageServersLoadedState(success));
      },
      (failure) {
        _emit(ManageServersErrorState());
      },
    );
    _isDiscovering = false;
  }
}

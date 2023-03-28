import 'package:result_dart/result_dart.dart';

import '../entities/manage_server_entity.dart';
import '../errors/manage_servers_failure.dart';
import '../repositories/manage_servers_network_repository.dart';

abstract class DiscoverServerUseCase {
  Future<Result<List<ManageServerEntity>, ManageServersFailure>> call(String subnet, List<int> ports);
}

class DiscoverServerUseCaseImpl implements DiscoverServerUseCase {
  final ManageServersNetworkRepository _repository;

  DiscoverServerUseCaseImpl(this._repository);
  @override
  Future<Result<List<ManageServerEntity>, ManageServersFailure>> call(String subnet, List<int> ports) {
    return _repository.discoverServers(subnet, ports);
  }
}

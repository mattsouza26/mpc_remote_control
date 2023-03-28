import 'package:result_dart/result_dart.dart';

import '../../domain/entities/manage_server_entity.dart';
import '../../domain/repositories/manage_servers_network_repository.dart';
import '../../domain/errors/manage_servers_failure.dart';
import '../data_source/manage_server_network_datasource.dart';

class ManageServersNetworkRepositoryImpl implements ManageServersNetworkRepository {
  final ManageServersNetworkDataSource _dataSource;

  ManageServersNetworkRepositoryImpl(this._dataSource);
  @override
  Future<Result<List<ManageServerEntity>, ManageServersFailure>> discoverServers(String subnet, List<int> ports) async {
    try {
      final result = await _dataSource.discoverServers(subnet, ports);
      if (result.isEmpty) return Failure(ManageServersFailure("Servers not found."));
      return Success(result);
    } catch (e) {
      return Failure(ManageServersFailure(e.toString()));
    }
  }
}

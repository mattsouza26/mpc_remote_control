import 'package:result_dart/result_dart.dart';

import '../errors/manage_servers_failure.dart';
import '../entities/manage_server_entity.dart';

abstract class ManageServersNetworkRepository {
  Future<Result<List<ManageServerEntity>, ManageServersFailure>> discoverServers(String subnet, List<int> ports);
}

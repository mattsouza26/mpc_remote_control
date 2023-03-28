import 'package:uuid/uuid.dart';

import '../../../../core/services/http_client/http_client_service.dart';
import '../../../../core/services/network/network_service.dart';
import '../dto/manage_server_dto.dart';

abstract class ManageServersNetworkDataSource {
  Future<List<ManageServerDTO>> discoverServers(String subnet, List<int> ports);
}

class ManageServersNetworkDataSourceImpl implements ManageServersNetworkDataSource {
  final NetworkService _networkService;
  final HttpClientService _httpClientService;

  ManageServersNetworkDataSourceImpl(this._networkService, this._httpClientService);
  @override
  Future<List<ManageServerDTO>> discoverServers(String subnet, List<int> ports) async {
    try {
      final List<ManageServerDTO> servers = await _networkService.discoverServers(subnet, ports).then((discoveredServers) async {
        final List<ManageServerDTO> servers = [];
        await Future.forEach(discoveredServers, (server) async {
          final f = _httpClientService.post("http://${server.ip}:${server.port}/command.html?wm_command=-1", timeout: const Duration(seconds: 1));
          await f.then((response) async {
            if (response.statusCode == 200) {
              servers.add(ManageServerDTO(id: const Uuid().v1(), name: "Local MPC Server", server: server));
            }
          }).catchError((e) => null);
        });
        return servers;
      });
      return servers;
    } catch (e) {
      rethrow;
    }
  }
}

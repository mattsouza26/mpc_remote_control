import '../../../../core/services/network/network_service.dart';

abstract class SettingsNetworkDataSouce {
  Future<String> getSubnet();
}

class SettingsNetworkDataSouceImpl implements SettingsNetworkDataSouce {
  final NetworkService _service;

  SettingsNetworkDataSouceImpl(this._service);
  @override
  Future<String> getSubnet() async {
    try {
      final subnet = await _service.getSubnet();
      if (subnet.isEmpty) throw Exception("");
      return subnet;
    } catch (e) {
      rethrow;
    }
  }
}

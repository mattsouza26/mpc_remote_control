import 'package:result_dart/result_dart.dart';
import '../../../../core/services/network/errors/network_failure.dart';
import '../../domain/repositories/settings_network_repository.dart';
import '../data_source/settings_network_datasource.dart';

class SettingsNetworkRepositoryImpl implements SettingsNetworkRepository {
  final SettingsNetworkDataSouce _dataSouce;

  SettingsNetworkRepositoryImpl(this._dataSouce);
  @override
  Future<Result<String, NetworkFailure>> getSubnet() async {
    try {
      final subnet = await _dataSouce.getSubnet();
      return Success(subnet);
    } catch (e) {
      return Failure(NetworkFailure());
    }
  }
}

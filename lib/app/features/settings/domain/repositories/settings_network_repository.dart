import 'package:result_dart/result_dart.dart';

import '../../../../core/services/network/errors/network_failure.dart';

abstract class SettingsNetworkRepository {
  Future<Result<String, NetworkFailure>> getSubnet();
}

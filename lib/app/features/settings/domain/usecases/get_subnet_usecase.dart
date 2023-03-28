import 'package:result_dart/result_dart.dart';

import '../../../../core/services/network/errors/network_failure.dart';
import '../repositories/settings_network_repository.dart';

abstract class GetSubnetUseCase {
  Future<Result<String, NetworkFailure>> call();
}

class GetSubnetUseCaseImpl implements GetSubnetUseCase {
  final SettingsNetworkRepository _repository;

  GetSubnetUseCaseImpl(this._repository);
  @override
  Future<Result<String, NetworkFailure>> call() async {
    return _repository.getSubnet();
  }
}

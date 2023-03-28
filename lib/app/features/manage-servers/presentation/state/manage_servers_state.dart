import '../models/manage_server_model.dart';

abstract class ManageServersState {}

class ManageServersLoadedState extends ManageServersState {
  final List<ManageServerModel> servers;
  ManageServersLoadedState(this.servers);
}

class ManageServersLoadingState extends ManageServersState {}

class ManageServersEmptyState extends ManageServersState {}

class ManageServersErrorState extends ManageServersState {}

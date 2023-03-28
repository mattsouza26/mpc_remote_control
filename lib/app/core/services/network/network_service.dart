import 'dart:isolate';

import 'package:network_discovery/network_discovery.dart';

import '../../models/server.dart';

abstract class NetworkService {
  Future<String> getSubnet();
  Future<List<Server>> discoverServers(String subnet, List<int> ports);
}

class NetworkServiceImpl implements NetworkService {
  @override
  Future<List<Server>> discoverServers(String subnet, List<int> ports) async {
    final servers = await Isolate.run<List<Server>>(() async {
      final List<Server> servers = [];
      final streamDiscovery = NetworkDiscovery.discoverMultiplePorts(subnet, ports);
      await for (var device in streamDiscovery) {
        await Future.forEach(device.openPorts, (port) {
          servers.add(Server(ip: device.ip, port: port));
        });
      }
      return servers;
    });
    return servers;
  }

  @override
  Future<String> getSubnet() async {
    try {
      final address = await NetworkDiscovery.discoverDeviceIpAddress();
      return address.substring(0, address.lastIndexOf('.'));
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mpc_remote_control/app/core/services/device_handler/device_handler_service.dart';
import 'package:mpc_remote_control/app/core/widgets/confirm_alert_dialog/confirm_alert_dialog.dart';

import '../../../../../core/enums/jump_distance.dart';
import '../../../../../core/widgets/settings_ui/settings_ui.dart';
import '../../controller/settings_controller.dart';
import '../dialogs/select_text_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsController _settingsController;

  @override
  void initState() {
    _settingsController = GetIt.I.get<SettingsController>();
    _settingsController.addListener(_updateScreenState);
    _settingsController.notification.addListener(_notificationPermission);

    Listenable.merge([_settingsController.incomingCall, _settingsController.afterCallEnd]).addListener(_phonePermission);

    super.initState();
  }

  void _notificationPermission() async {
    if (!_settingsController.notification.value) return;
    final result = await GetIt.I.get<DeviceHandlerService>().requestNotificationPermission();
    if (!result) {
      _settingsController.notification.value = false;
    }
  }

  void _phonePermission() async {
    if (!_settingsController.incomingCall.value && !_settingsController.afterCallEnd.value) return;

    final result = await GetIt.I.get<DeviceHandlerService>().requestPhonePermission();
    if (!result) {
      _settingsController.incomingCall.value = false;
      _settingsController.afterCallEnd.value = false;
    }
  }

  @override
  void dispose() {
    _settingsController.removeListener(_updateScreenState);
    _settingsController.notification.removeListener(_notificationPermission);
    Listenable.merge([_settingsController.incomingCall, _settingsController.afterCallEnd]).removeListener(_phonePermission);
    super.dispose();
  }

  void _updateScreenState() {
    if (!mounted) return;
    setState(() {});
  }

  void _selectSubnet(String subnet) async {
    final selectedSubnet = await showDialog<String>(
      context: context,
      builder: (context) => SelectTextDialog(
        title: "Select Subnet",
        labelText: "Subnet",
        helperText: '* Insert your IP Address without the final period and digits.',
        hintText: "192.168.0",
        initalValue: subnet,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9\.]")),
          FilteringTextInputFormatter.deny(RegExp("[aA-zZ]")),
        ],
        inputValidator: (value) {
          final String subnet = value ?? "";
          if (subnet.isEmpty) return "Can't be empty";
          if (subnet.endsWith(".")) return 'Cannot end with ( . )';
          final RegExp regex = RegExp(r'^(25[0-5]|(2[0-4]|1\d|[0-9])){1,3}\.[0-9]{1,3}\.[0-9]{1,3}$');
          if (!regex.hasMatch(subnet)) return "Invalid Subnet (E.g 192.168.0)";

          return null;
        },
        keyboardType: const TextInputType.numberWithOptions(),
      ),
    );
    if (selectedSubnet != null) {
      _settingsController.subnet.value = selectedSubnet;
    }
  }

  void _selectPorts(List<int> ports) async {
    final selectedPorts = await showDialog<String>(
      context: context,
      builder: (context) => SelectTextDialog(
        title: "Select Ports",
        labelText: "Ports",
        helperText: "* Please enter the ports numbers separated by ( , )",
        hintText: "80,443,8080",
        initalValue: ports.join(","),
        inputValidator: (value) {
          final String ports = value ?? "";
          if (ports.isEmpty) return "Can't be empty";
          if (ports.endsWith(",")) return 'Cannot end with ( , )';
          final List<String> listPorts = ports.split(",");
          for (String strPort in listPorts) {
            final int? port = int.tryParse(strPort);
            if (port == null) return "Please enter a valid integer value.";
            if (port < 0 || port > 65535) {
              return "Provide a valid port range between 0 to 65535";
            } else {
              continue;
            }
          }
          return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
          FilteringTextInputFormatter.deny(RegExp("[aA-zZ]")),
        ],
        keyboardType: const TextInputType.numberWithOptions(),
      ),
    );
    if (selectedPorts != null) {
      _settingsController.ports.value = selectedPorts.split(',').map((e) => int.parse(e)).toList();
    }
  }

  void _confirmCleanCache() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmAlertDialog(
        title: "Reset Settings?",
        message: "This will reset your settings to its default settings.",
      ),
    );

    if (result == null || !result) return;

    _settingsController.clearAppCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          primary: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              children: [
                SettingsSection(
                  sectionName: const Text("App"),
                  settings: [
                    SettingsTileSwitch(
                      title: const Text("Dark Mode"),
                      subTitle: const Text("Enable dark theme"),
                      value: _settingsController.appTheme.value == ThemeMode.dark,
                      onChanged: (value) => _settingsController.toggleTheme(),
                    ),
                    SettingsTileCheckBox(
                      title: const Text("Keep Screen On"),
                      subTitle: const Text("Prevent screen from turning off"),
                      value: _settingsController.keepScreenOn.value,
                      onChanged: (value) => _settingsController.keepScreenOn.value = value!,
                    ),
                    SettingsTileCheckBox(
                      title: const Text("Notification"),
                      subTitle: const Text("Show notification"),
                      value: _settingsController.notification.value,
                      onChanged: (value) => _settingsController.notification.value = value!,
                    ),
                    SettingsTileCheckBox(
                      title: const Text("Use Hardware Volume Keys"),
                      subTitle: const Text("Control volume using device volume keys"),
                      value: _settingsController.useHardwareVolumeKeys.value,
                      onChanged: (value) => _settingsController.useHardwareVolumeKeys.value = value!,
                    ),
                    SettingsTileCheckBox(
                      title: const Text("Incoming call"),
                      subTitle: const Text("Pause on incoming call"),
                      value: _settingsController.incomingCall.value,
                      onChanged: (value) => _settingsController.incomingCall.value = value!,
                    ),
                    SettingsTileCheckBox(
                      title: const Text("After call end"),
                      subTitle: const Text("Play after end of call"),
                      value: _settingsController.afterCallEnd.value,
                      onChanged: (value) => _settingsController.afterCallEnd.value = value!,
                    ),
                    SettingsTile(
                      title: const Text("Clear App Cache"),
                      onPressed: () => _confirmCleanCache(),
                    )
                  ],
                ),
                SettingsSection(
                  sectionName: const Text('Server'),
                  settings: [
                    SettingsTile(
                      title: const Text("Subnet"),
                      subTitle: const Text("Subnet address that going to be used for find server"),
                      onPressed: () => _selectSubnet(_settingsController.subnet.value),
                    ),
                    SettingsTile(
                      title: const Text("Ports"),
                      subTitle: const Text("Ports that going to be used for find server"),
                      onPressed: () => _selectPorts(_settingsController.ports.value),
                    ),
                    SettingsTileSwitch(
                      title: const Text("Auto Connect"),
                      subTitle: const Text("Auto connect to the last server"),
                      value: _settingsController.autoConnect.value,
                      onChanged: (value) => _settingsController.autoConnect.value = value,
                    ),
                  ],
                ),
                SettingsSection(
                  sectionName: const Text("File Manager"),
                  settings: [
                    SettingsTileCheckBox(
                      title: const Text("Unsupported files"),
                      subTitle: const Text("Show unsupported files"),
                      value: _settingsController.unsupportedFiles.value,
                      onChanged: (value) => _settingsController.unsupportedFiles.value = value!,
                    ),
                    SettingsTileCheckBox(
                      title: const Text("File extension"),
                      subTitle: const Text("Show file extension"),
                      value: _settingsController.fileExtension.value,
                      onChanged: (value) => _settingsController.fileExtension.value = value!,
                    ),
                    SettingsTileCheckBox(
                      title: const Text("Full filename"),
                      subTitle: const Text("Show full files name"),
                      value: _settingsController.fullFileName.value,
                      onChanged: (value) => _settingsController.fullFileName.value = value!,
                    ),
                  ],
                ),
                SettingsSection(
                  sectionName: const Text('Controls'),
                  settings: [
                    SettingsTileDropDown<JumpDistance>(
                      title: const Text("Jump Distance"),
                      subTitle: const Text("Set custom jump distance"),
                      value: _settingsController.jumpDistance.value,
                      items: JumpDistance.values.map((jump) => DropdownMenuItem(value: jump, child: Text(jump.name))).toList(),
                      onChanged: (value) => _settingsController.jumpDistance.value = value!,
                    ),
                    SettingsTileNavigation(
                      title: const Text("Custom Controls"),
                      subTitle: const Text("Create your own controls"),
                      onPressed: () => context.pushNamed(
                        "edit-custom-controls-screen",
                        extra: _settingsController.customControls.value,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

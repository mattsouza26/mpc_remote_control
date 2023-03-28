import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mpc_remote_control/app/core/widgets/confirm_alert_dialog/confirm_alert_dialog.dart';

import '../../../../../core/models/command.dart';
import '../../controller/settings_controller.dart';
import '../dialogs/add_command_dialog.dart';

class EditCustomControlsScreen extends StatefulWidget {
  const EditCustomControlsScreen({super.key});

  @override
  State<EditCustomControlsScreen> createState() => _EditCustomControlsScreenState();
}

class _EditCustomControlsScreenState extends State<EditCustomControlsScreen> {
  late final SettingsController _settingsController;
  late final List<Command> _controls;

  @override
  void initState() {
    _settingsController = GetIt.instance.get<SettingsController>();
    _controls = List.from(_settingsController.customControls.value).cast<Command>();
    super.initState();
  }

  void _reorderCommand(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = _controls.removeAt(oldindex);
      _controls.insert(newindex, items);
    });
  }

  void _addCommand() async {
    final List<Command>? commands = await showDialog<List<Command>>(
      context: context,
      builder: (context) => const AddCommandDialog(),
    );
    if (commands == null) return;
    setState(() {
      for (var command in commands) {
        if (!_controls.contains(command)) {
          _controls.add(command);
        }
      }
    });
  }

  void _removeCommand(Command command) {
    setState(() {
      _controls.remove(command);
    });
  }

  void _save() {
    _settingsController.customControls.value = _controls;
    Navigator.of(context).pop();
  }

  Future<bool> checkCanLeave() async {
    if (listEquals(_controls, _settingsController.customControls.value) == false) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const ConfirmAlertDialog(
            title: 'You want to leave?',
            message: 'If you leave without saving you may lose all yours changes',
          );
        },
      );
      if (confirm == null || !confirm) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: checkCanLeave,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text("Custom Controls"),
          actions: [
            IconButton(
              onPressed: _save,
              icon: const Icon(Icons.check),
            )
          ],
        ),
        body: ReorderableListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          proxyDecorator: (child, index, animation) => Material(
            type: MaterialType.transparency,
            child: child,
          ),
          buildDefaultDragHandles: false,
          onReorder: _reorderCommand,
          itemCount: _controls.length,
          itemBuilder: (context, index) {
            final command = _controls[index];
            return Material(
              type: MaterialType.card,
              elevation: 5,
              key: ValueKey(command.cod),
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                padding: const EdgeInsets.only(left: 15.0, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(command.name),
                    ),
                    SizedBox(
                      width: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => _removeCommand(command),
                            child: const Icon(
                              Icons.delete,
                            ),
                          ),
                          ReorderableDragStartListener(
                            index: index,
                            child: const Icon(
                              Icons.menu_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addCommand,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

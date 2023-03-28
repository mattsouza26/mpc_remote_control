import 'package:flutter/material.dart';

import '../../../../../core/models/command.dart';
import '../../../../../core/utils/commands_utils.dart';

class AddCommandDialog extends StatefulWidget {
  const AddCommandDialog({super.key});

  @override
  State<AddCommandDialog> createState() => _AddCommandDialogState();
}

class _AddCommandDialogState extends State<AddCommandDialog> {
  final List<Command> _listCommand = ControllerCommands.listCommands;
  bool _isSelectable = false;

  final List<Command> _commandSelected = [];

  bool? _allSelectedValidate() {
    if (_commandSelected.length == _listCommand.length) {
      return true;
    }
    if (_commandSelected.isNotEmpty && _commandSelected.length != _listCommand.length) {
      return null;
    }
    return false;
  }

  void _addSelected(Command selectedCommand) {
    setState(() {
      _commandSelected.add(selectedCommand);
    });
  }

  void _removeSelected(Command selectedCommand) {
    setState(() {
      _commandSelected.remove(selectedCommand);
    });
  }

  void _selectMultipleCommand(bool? select) {
    setState(() {
      if (select != null) {
        _commandSelected.clear();
        _commandSelected.addAll(_listCommand);
      } else {
        _commandSelected.clear();
      }
    });
  }

  void _cancelMultipleSelectable() {
    setState(() {
      _isSelectable = false;
      _commandSelected.clear();
    });
  }

  bool _isSelected(Command command) {
    return _commandSelected.contains(command);
  }

  void _saveCommands(Command command) async {
    Navigator.of(context).pop([command]);
  }

  void _saveMultipleCommands() async {
    Navigator.of(context).pop(_commandSelected);
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: _isSelectable,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: _cancelMultipleSelectable,
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select Command',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Visibility(
                    visible: _isSelectable,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: _allSelectedValidate(),
                        tristate: true,
                        onChanged: _selectMultipleCommand,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isSelectable,
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _listCommand.length,
                  itemBuilder: (context, index) {
                    final command = _listCommand[index];
                    return CheckboxListTile(
                      value: _isSelected(command),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _addSelected(command);
                          } else {
                            _removeSelected(command);
                          }
                        });
                      },
                      // onTap: () => Navigator.of(context).pop(ControllerCommands.listCommands[index]),
                      title: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          command.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: !_isSelectable,
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _listCommand.length,
                  itemBuilder: (context, index) {
                    final command = _listCommand[index];
                    return ListTile(
                      onTap: () => _saveCommands(command),
                      onLongPress: () => setState(() {
                        _addSelected(command);
                        _isSelectable = true;
                      }),
                      title: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          command.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (_isSelectable)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(onPressed: () => _cancel(), child: const Text('CANCEL')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(onPressed: () => _saveMultipleCommands(), child: const Text('ADD')),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

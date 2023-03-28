// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc_remote_control/app/features/manage-servers/presentation/models/manage_server_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/models/server.dart';

class ManageServerDetailsDialog extends StatefulWidget {
  final ManageServerModel? manageServer;
  const ManageServerDetailsDialog({
    Key? key,
    this.manageServer,
  }) : super(key: key);

  @override
  State<ManageServerDetailsDialog> createState() => _UpdateManageServerState();
}

class _UpdateManageServerState extends State<ManageServerDetailsDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> formData = {'id': null, 'name': '', 'ip': "", 'port': ""};

  @override
  void initState() {
    _updateFormData(
      id: widget.manageServer?.id,
      name: widget.manageServer?.name,
      ip: widget.manageServer?.server.ip,
      port: widget.manageServer?.server.port.toString(),
    );
    super.initState();
  }

  void _submitForm() {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;
    final newServer = ManageServerModel(
      id: formData['id'],
      name: formData['name'],
      server: Server(
        ip: formData['ip'],
        port: int.tryParse(formData['port']) ?? 0,
      ),
    );
    Navigator.of(context).pop(newServer);
  }

  void _updateFormData({String? id, String? name, String? ip, String? port}) {
    setState(() {
      formData = {
        'id': id ?? formData['id'] ?? const Uuid().v1(),
        'name': name ?? formData['name'],
        'ip': ip ?? formData['ip'],
        'port': port ?? formData['port'],
      };
    });
  }

  bool _emptyFormValidate() {
    final String name = formData['name'];
    final String ip = formData['ip'];
    final String port = formData['port'];
    if (name.isEmpty || ip.isEmpty || port.isEmpty) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(viewInsets: const EdgeInsets.only(bottom: 100)),
        child: Dialog(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Server Details",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: formData['name'],
                        onChanged: (value) => _updateFormData(name: value),
                        decoration: const InputDecoration(labelText: "Name"),
                        validator: (value) {
                          final String newValue = value ?? "";
                          if (newValue.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: formData['ip'],
                        onChanged: (value) => _updateFormData(ip: value),
                        decoration: const InputDecoration(labelText: "IP Address"),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                          FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                          FilteringTextInputFormatter.deny(RegExp("[aA-zZ]")),
                        ],
                        validator: (value) {
                          final String newValue = value ?? "";
                          if (newValue.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          if (!RegExp(r"^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)(\.(?!$)|$)){4}$").hasMatch(newValue)) {
                            return 'Please enter a valid IP';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: formData['port'],
                        onChanged: (value) => _updateFormData(port: value),
                        decoration: const InputDecoration(labelText: "Port"),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          FilteringTextInputFormatter.deny(RegExp("[aA-zZ]")),
                        ],
                        validator: (value) {
                          final String newValue = value ?? "";
                          if (newValue.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          if (int.tryParse(newValue) == null) {
                            return "Invalid port number";
                          }

                          if (int.parse(newValue) - 0 < 0 || int.parse(newValue) > 65535) {
                            return 'Port should be between 0 and 65535';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("CANCEL"),
                    ),
                    TextButton(
                      onPressed: _emptyFormValidate() ? () => _submitForm() : null,
                      child: const Text("SAVE"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

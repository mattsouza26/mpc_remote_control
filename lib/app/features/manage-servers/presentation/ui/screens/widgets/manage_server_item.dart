// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mpc_remote_control/app/features/manage-servers/presentation/models/manage_server_model.dart';

class ManageServerItem extends StatelessWidget {
  final ManageServerModel manageServer;
  final bool isSelected;
  final void Function() onConnect;
  final void Function() onDisconnect;
  final void Function() onDelete;
  final void Function() onEdit;
  const ManageServerItem({
    Key? key,
    required this.manageServer,
    required this.isSelected,
    required this.onConnect,
    required this.onDisconnect,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
            strokeAlign: -1.0,
          ),
        ),
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(manageServer.name),
        subtitle: Text(manageServer.server.toAddress()),
        leading: Icon(
          Icons.tv,
          color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
          size: 35,
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert_rounded),
          itemBuilder: (context) => [
            if (!isSelected)
              PopupMenuItem(
                onTap: onConnect,
                child: const Text("Connect"),
              )
            else
              PopupMenuItem(
                onTap: onDisconnect,
                child: const Text("Disconnect"),
              ),
            PopupMenuItem(
              onTap: onEdit,
              child: const Text("Edit"),
            ),
            PopupMenuItem(
              onTap: onDelete,
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}

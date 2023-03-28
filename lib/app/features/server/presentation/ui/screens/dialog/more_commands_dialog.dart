// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mpc_remote_control/app/core/routes/app_route.dart';

import '../../../../../../core/models/command.dart';

class MoreCommandsDialog extends StatelessWidget {
  final List<Command> commands;
  final void Function(Command)? onPressed;
  const MoreCommandsDialog({
    Key? key,
    required this.commands,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.175),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: commands.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 0, color: Theme.of(context).colorScheme.onSecondaryContainer),
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: commands.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => onPressed?.call(commands[index]),
                    child: Material(
                      type: MaterialType.transparency,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          commands[index].name,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 35),
                    const FittedBox(child: Text("You don't have any custom controls yet.")),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(AppRoute.settingsScreen);
                      },
                      child: const Text("Go to Settings"),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EmptyManageServers extends StatelessWidget {
  const EmptyManageServers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: const Alignment(0, -0.4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: double.infinity),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.headlineSmall?.color ?? Colors.white,
              BlendMode.srcIn,
            ),
            child: const Image(
              height: 175,
              image: AssetImage("lib/app/core/assets/images/manage-servers/empty_servers.png"),
            ),
          ),
          const SizedBox(height: 20),
          FittedBox(
            child: Text(
              "Looks like you haven't added a server yet.",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 5),
          FittedBox(
            child: Text(
              "Start by adding an server or try to discover one.",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
